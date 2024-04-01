data "http" "sandbox_trust_policy" {
  url = "${local.artifact_base_url}/trust.json"
}
