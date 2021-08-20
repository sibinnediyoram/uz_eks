provider "aws" {
  region = "eu-central-1"
}

provider "random" {
  version = "~> 2.2.1"
}

data "aws_caller_identity" "current" {}