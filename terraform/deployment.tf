locals {
  blue_deployment = yamldecode(file("../manifests/blue-deployment.yml"))
  blue_clusterip = yamldecode(file("../manifests/blue-clusterIP.yml"))
  blue_servicemonitor = yamldecode(file("../manifests/blue-servicemonitor.yml"))
  blue_promtail_configmap = yamldecode(file("../manifests/blue-promtail.yml"))

  green_deployment = yamldecode(file("../manifests/green-deployment.yml"))
  green_clusterip = yamldecode(file("../manifests/green-clusterIP.yml"))
  green_servicemonitor = yamldecode(file("../manifests/green-servicemonitor.yml"))
  green_promtail_configmap = yamldecode(file("../manifests/green-promtail.yml"))

  planetarium_deployment = yamldecode(file("../manifests/planetarium-secret.yml"))
  planetarium_clusterip = yamldecode(file("../manifests/planetarium-clusterIP.yml"))
  planetarium_servicmonitor = yamldecode(file("../manifests/planetarium-servicmonitor.yml"))
  planetarium_ingress = yamldecode(file("../manifests/planetarium-ingress.yml"))
}

resource "kubernetes_manifests" "blue_deployment"{
  manifes
}