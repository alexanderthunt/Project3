locals {
  blue_deployment         = yamldecode(file("../manifests/deployment_blue/deployment.yml"))
  blue_clusterip          = yamldecode(file("../manifests/deployment_blue/clusterIP.yml"))
  blue_servicemonitor     = yamldecode(file("../manifests/deployment_blue/servicemonitor.yml"))
  blue_promtail_configmap = yamldecode(file("../manifests/deployment_blue/promtail.yml"))

  green_deployment         = yamldecode(file("../manifests/deployment_green/deployment.yml"))
  green_clusterip          = yamldecode(file("../manifests/deployment_green/clusterIP.yml"))
  green_servicemonitor     = yamldecode(file("../manifests/deployment_green/servicemonitor.yml"))
  green_promtail_configmap = yamldecode(file("../manifests/deployment_green/promtail.yml"))

  planetarium_clusterip      = yamldecode(file("../manifests/planetarium/clusterIP.yml"))
  planetarium_servicemonitor = yamldecode(file("../manifests/planetarium/servicemonitor.yml"))
  planetarium_ingress        = yamldecode(file("../manifests/planetarium/ingress.yml"))

  dashboard_configmap_blue_green    = yamldecode(file("../manifests/dashboard/blue_green.yml"))
  dashboard_configmap_burn_rate     = yamldecode(file("../manifests/dashboard/burn_rate.yml"))
  dashboard_configmap_green_utility = yamldecode(file("../manifests/dashboard/green_utility.yml"))
}

data "template_file" "planetarium_secret" {
  template = file("../manifests/planetarium/secret.yml")

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

resource "kubernetes_manifest" "dashboard_configmap_blue_green" {
  manifest = local.dashboard_configmap_blue_green
}

resource "kubernetes_manifest" "dashboard_configmap_burn_rate" {
  manifest = local.dashboard_configmap_burn_rate
}

resource "kubernetes_manifest" "dashboard_configmap_green_utility" {
  manifest = local.dashboard_configmap_green_utility
}

resource "kubernetes_manifest" "rules_records" {
  manifest = yamldecode(file("../manifests/rules/records.yml"))
}

resource "kubernetes_manifest" "rules_alerts" {
  manifest = yamldecode(file("../manifests/rules/alerts.yml"))
}

resource "kubernetes_manifest" "rules_burn_rate" {
  manifest = yamldecode(file("../manifests/rules/burn-rate.yml"))
}
