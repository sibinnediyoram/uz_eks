terraform {
  required_version = "~> 0.13.7" # which means ">= 0.13.1" and "< 0.14"
  backend "s3" {
    bucket  = "uz-app-infra-eu"
    key     = "aws/development/terraform.tfstate"
    region  = "eu-central-1"
    profile = "default"
  }
}