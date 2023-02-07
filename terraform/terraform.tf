terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes",
      version = "2.17.0"
    }
    # aws = {
    #   source  = "hashicorp/aws",
    #   version = "4.53.0"
    # }
  }

  # backend "s3" {
  #   bucket  = "team-sol-bucket"
  #   key     = "default.tfstate"
  #   encrypt = true
  # }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# provider "aws" {
#   region  = "us-east-1"
#   profile = ""
# }

# module "s3-bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "3.6.1"
# }