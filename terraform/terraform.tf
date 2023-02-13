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

## Provides configuration for Helm to connect to EKS
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

## Installs Loki chart
resource "helm_release" "loki" {
  name  = "loki"
  chart = "grafana/loki-stack"
}

## Installs Ingress-nginx chart
resource "helm_release" "nginx" {
  name  = "nginx"
  chart = "ingress-nginx/ingress-nginx"
}

## Installs Prometheus chart
resource "helm_release" "prometheus" {
  name  = "prometheus"
  chart = "prometheus-community/kube-prometheus-stack"

  values = [
    "${file("chart_values/prometheus-values.yml")}"
  ]
}

## Installs Jenkins chart
resource "helm_release" "jenkins" {
  name  = "jenkins"
  chart = "jenkins/jenkins"

  values = [
    "${file("chart_values/jenkins-values.yml")}"
  ]
}

## Grafana E-mail Secret

resource "kubernetes_manifest" "grafana-email" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "email_username" = var.email_username
      "email_password" = var.email_password
    }
    "kind" = "Secret"
    "metadata" = {
      "name"      = "grafana-email"
      "namespace" = "default"
    }
    "type" = "Opaque"
  }
}