locals {
  blue_deployment         = yamldecode(file("../manifests/blue-deployment.yml"))
  blue_clusterip          = yamldecode(file("../manifests/blue-clusterIP.yml"))
  blue_servicemonitor     = yamldecode(file("../manifests/blue-servicemonitor.yml"))
  blue_promtail_configmap = yamldecode(file("../manifests/blue-promtail.yml"))

  green_deployment         = yamldecode(file("../manifests/green-deployment.yml"))
  green_clusterip          = yamldecode(file("../manifests/green-clusterIP.yml"))
  green_servicemonitor     = yamldecode(file("../manifests/green-servicemonitor.yml"))
  green_promtail_configmap = yamldecode(file("../manifests/green-promtail.yml"))

  planetarium_clusterip      = yamldecode(file("../manifests/planetarium-clusterIP.yml"))
  planetarium_servicemonitor = yamldecode(file("../manifests/planetarium-servicemonitor.yml"))
  planetarium_ingress        = yamldecode(file("../manifests/planetarium-ingress.yml"))
}

data "template_file" "planetarium_secret" {
  template = file("../manifests/planetarium-secret.yml")

  vars = {
    data_url = var.spring_url
    username = var.spring_username
    password = var.spring_password
  }
}

resource "kubernetes_manifest" "blue_deployment" {
  manifest = local.blue_deployment
}

resource "kubernetes_manifest" "blue_clusterip" {
  manifest = local.blue_clusterip
}

resource "kubernetes_manifest" "blue_servicemonitor" {
  manifest = local.blue_servicemonitor
}

resource "kubernetes_manifest" "blue_configmap" {
  manifest = local.blue_promtail_configmap
}

resource "kubernetes_manifest" "green_deployment" {
  manifest = local.green_deployment
}

resource "kubernetes_manifest" "green_clusterip" {
  manifest = local.green_clusterip
}

resource "kubernetes_manifest" "green_servicemonitor" {
  manifest = local.green_servicemonitor
}

resource "kubernetes_manifest" "green_configmap" {
  manifest = local.green_promtail_configmap
}

resource "kubernetes_manifest" "planetarium_ingress" {
  manifest = local.planetarium_ingress
}

resource "kubernetes_manifest" "planetarium_secret" {
  manifest = yamldecode(data.template_file.planetarium_secret.rendered)
}

resource "kubernetes_manifest" "planetarium_clusterip" {
  manifest = local.planetarium_clusterip
}

resource "kubernetes_manifest" "planetarium_servicemonitor" {
  manifest = local.planetarium_servicemonitor
}
