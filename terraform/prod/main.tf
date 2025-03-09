module "amplify" {
  source = "../modules/amplify"

  app_name = "jpdevs-front-prod"
  repository_url = "https://github.com/julianmarcelolopez/jpdevs-front"
  environment    = "prod"
  branch_name    = "main"
  github_access_token = var.github_access_token

  branches = {
    main = {
      framework = "React"
      stage = "PRODUCTION"
      enable_auto_build = true
      enable_basic_auth = false
      basic_auth_credentials = ""
      environment_variables = {}
    },
    develop = {
      framework = "React"
      stage = "DEVELOPMENT"
      enable_auto_build = true
      enable_basic_auth = false
      basic_auth_credentials = ""
      environment_variables = {
        REACT_APP_MAIL_SENDER_URL = "https://develop.d13c67jud9spm1.amplifyapp.com/"
        REACT_APP_QR_SCANNER_URL = "https://develop.d8eci5asqo38h.amplifyapp.com/"
      }
    }
  }
}

output "amplify_app_url" {
  value = module.amplify.main_branch_url
}

output "all_branch_urls" {
  value = module.amplify.branch_urls
}