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
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts/"
  chart      = "loki-stack"
}

## Installs Ingress-nginx chart
resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx/"
  chart      = "ingress-nginx"
}

## Installs Prometheus chart
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts/"
  chart      = "kube-prometheus-stack"

  values = [
    "${file("chart_values/prometheus-values.yml")}"
  ]

  set {
    name  = "alertmanager.config.global.smtp_auth_password"
    value = var.email_password
  }

  set {
    name  = "alertmanager.config.global.smtp_auth_username"
    value = var.email_username
  }

  set {
    name  = "alertmanager.config.global.smtp_from"
    value = var.email_username
  }

  set {
    name  = "alertmanager.config.receivers[1].email_configs[0].to"
    value = var.email_address
  }

  set {
    name  = "grafana.grafana\\.ini.smtp.user"
    value = var.email_username
  }

  set {
    name  = "grafana.grafana\\.ini.smtp.password"
    value = var.email_password
  }

  set {
    name  = "grafana.grafana\\.ini.smtp.from_address"
    value = var.email_username
  }
}

## Installs Jenkins chart
resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"

  values = [
    "${file("chart_values/jenkins-values.yml")}"
  ]
}
