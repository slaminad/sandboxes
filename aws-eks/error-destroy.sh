#!/bin/sh

# script that runs if tf fails: attempts to delete any and all trailing resources

set -u
set -o pipefail


echo "executing error-destroy script"
echo
echo '     region: '$AWS_REGION
echo '    profile: '$AWS_PROFILE
echo ' install id: '$NUON_INSTALL_ID
echo


echo "ensuring AWS is setup"
aws sts get-caller-identity > /dev/null

#
# Nat Gateways
#

echo "looking for NAT Gateways"
NAT_GATEWAYS=$(aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-nat-gateways --filter Name=tag:Name,Values=$NUON_INSTALL_ID*)
echo $NAT_GATEWAYS | jq -r '.NatGateways[].NatGatewayId' | while read -r nat_gateway_id; do
  echo "deleting NAT Gateway "$nat_gateway_id
  aws --profile $AWS_PROFILE --region $AWS_REGION  ec2 delete-nat-gateway --nat-gateway-id $nat_gateway_id
done

#
# VPC Cleanup: Resources
#

function delete_vpc_subnets() {
  SNS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.Subnets'`
  echo $SNS | jq -r '.[].SubnetId' | while read sn_id; do
    echo " - deleting subnet "$sn_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-subnet --subnet-id $sn_id
  done
}

function delete_vpc_security_groups() {
  SGS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.SecurityGroups'`
  echo $SGS | jq -r '.[].GroupId' | while read sg_id; do
    echo " - deleting sg "$sg_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-security-group --group-id $sg_id
  done
}

function disassociate_vpc_security_groups() {
  # useful for SGs that reference each other
  # in the context of this script, it should only be run near then end right before we delete the sg then vpc.
  # it exists only because there are a small number of SGs that cannot be deletd otherwise.
  SGS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.SecurityGroups'`
  echo $SGS | jq -c '.[]' | while read sg; do
    sg_name=`echo "$sg" | jq -r '.Name'`
    if [[ "$sg_name" == "default" ]]; then
      echo "politely refusing to delete default vpc security group"
    else
      sg_id=`echo "$sg" | jq -r '.GroupId'`
      group_ids=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-security-group-rules --filters 'Name=group-id,Values='$sg_id | jq -r '.SecurityGroupRules.[].SecurityGroupRuleId'`
      aws --profile $AWS_PROFILE --region $AWS_REGION ec2 revoke-security-group-ingress --group-id $sg_id --security-group-rule-ids $group_ids
    fi
  done
}

function delete_vpc_resources() {
  # deletes all of the resources tagged with a specific VPC.
  # this is intended to be run multiple times.
  vpc_id=$1
  echo "["$vpc_id"] Looking for resources"

  delete_vpc_security_groups $vpc_id

  IGWS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc_id | jq -r '.InternetGateways'`
  echo $IGWS | jq -r '.[].InternetGatewayId' | while read ig_id; do
    echo " - detaching internet gateway "$ig_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 detach-internet-gateway --internet-gateway-id $ig_id --vpc-id $vpc_id
    echo " - deleting internet gateway "$ig_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-internet-gateway --internet-gateway-id $ig_id
  done

  delete_vpc_subnets $vpc_id

  NACLS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-network-acls --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.NetworkAcls'`
  echo $NACLS | jq -r '.[].NetworkAclId' | while read na_id; do
    echo "- deleting network acl "$na_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-network-acl --network-acl-id $na_id
  done

  RTTBLS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.RouteTables'`
  echo $RTTBLS | jq -r '.[].RouteTableId' | while read rt_id; do
    echo " - deleting route table "$rt_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-route-table --route-table-id $rt_id
  done

  NGWS=`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-nat-gateways --filter 'Name=vpc-id,Values='$vpc_id | jq -r '.NatGateways'`
  echo $NGWS | jq -r '.[].NatGatewayId' | while read ngw_id; do
    echo "- deleting nat gateway "$ngw_id
    aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-nat-gateway --nat-gateway-id $ngw_id
  done
}

echo "looking for vpc..."
VPCS=$(aws --profile $AWS_PROFILE --region $AWS_REGION ec2 \
  describe-vpcs \
  --filters Name=tag:Name,Values=$NUON_INSTALL_ID)

echo $VPCS | jq -r '.Vpcs[].VpcId' | while read -r vpc_id ; do
  delete_vpc_resources $vpc_id
done

#
# Load Balancers
#
echo "looking for Load Balancers"
NLBS=$(aws --profile $AWS_PROFILE --region $AWS_REGION  elbv2 describe-load-balancers | jq '.LoadBalancers')
echo $NLBS | jq -r '.[].LoadBalancerArn' | while read -r lb_arn; do
  tag_values=$(aws --profile $AWS_PROFILE --region $AWS_REGION  elbv2 describe-tags --resource-arn $lb_arn | jq -r '.TagDescriptions[].Tags.[].Value')
  if [[ $tag_values == *"$NUON_INSTALL_ID"*  ]]; then
    echo "deleting load balancer "$lb_arn
    aws --profile $AWS_PROFILE --region $AWS_REGION  elbv2 delete-load-balancer --load-balancer-arn $lb_arn
  fi
done

echo "looking for loadbalancer security groups..."
SGS=$(aws --profile $AWS_PROFILE --region $AWS_REGION ec2 \
  describe-security-groups \
  --filters Name=tag:elbv2.k8s.aws/cluster,Values=$NUON_INSTALL_ID)

echo $SGS | jq -r '.SecurityGroups[].GroupId' | while read -r sg_id ; do
  echo "deleting security group $sg_id"
  aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-security-group --group-id=$sg_id
done

#
# ENIs
#

echo "looking for ENIs which were orphaned by vpc-cni plugin"
ENIS=$(aws --profile $AWS_PROFILE --region $AWS_REGION ec2 \
  describe-network-interfaces \
  --filters Name=tag:cluster.k8s.amazonaws.com/name,Values=$NUON_INSTALL_ID)

echo $ENIS | jq -r '.NetworkInterfaces[].NetworkInterfaceId' | while read -r eni_id ; do
  echo "deleting ENI $eni_id"
  aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-network-interface --network-interface-id=$eni_id
done

#
# Security Groups: Clean up remaining security groups
#

echo "looking for nuon security groups..."
SGS=$(aws --profile $AWS_PROFILE --region $AWS_REGION ec2 \
  describe-security-groups \
  --filters Name=tag:nuon_id,Values=$NUON_INSTALL_ID)

echo $SGS | jq -r '.SecurityGroups[].GroupId' | while read -r sg_id ; do
  echo "deleting security group $sg_id"
  aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-security-group --group-id=$sg_id
done

#
# VPC Cleanup: VPC
#

# clean up any resources we couldn't get to before
echo $VPCS | jq -r '.Vpcs[].VpcId' | while read -r vpc_id ; do
  disassociate_vpc_security_groups $vpc_id
  delete_vpc_resources $vpc_id
done

echo $VPCS | jq -r '.Vpcs[].VpcId'
echo $VPCS | jq -r '.Vpcs[].VpcId' | while read -r vpc_id ; do
  echo "deleting vpc $vpc_id"
  aws --profile $AWS_PROFILE --region $AWS_REGION ec2 delete-vpc --vpc-id=$vpc_id
done
