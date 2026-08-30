# Port provider configuration.
#
# Auth is environment-based (set by the promotion workflow per GitHub Environment):
#   PORT_CLIENT_ID / PORT_CLIENT_SECRET  — OAuth machine-user credentials
#   PORT_BASE_URL                        — optional; defaults to https://api.us.port.io
#                                          (US). Set https://api.port.io for EU.
#   PORT_BETA_FEATURES_ENABLED=true      — required when managing pages/folders
#
# The live Port org is whatever org those credentials belong to.
# No org slug is hardcoded here.
#
# Local name is port-labs (matches terraform-import-generator default and
# generate-config-out). Do not pass --provider-alias port.

provider "port-labs" {
  # client_id / secret / base_url resolved from environment variables above.
}
