terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes",
      version = "~> 2.17.0"
    }
    aws = {
      source  = "hashicorp/aws",
      version = "~> 4.53.0"
    }
  }

  backend "s3" {
    region  = "us-east-1"
    profile = "team-sol"
    bucket  = "team-sol-bucket"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

## EKS credential directory

provider "kubernetes" {
  config_path = "~/.kube/config"
}

## AWS credential

provider "aws" {
  region  = "us-east-1"
  profile = "team-sol"
}

## Module to create an S3 Bucket in AWS

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "team-sol-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}