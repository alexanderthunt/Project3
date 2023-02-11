## Kubernetes Secret

resource "kubernetes_manifest" "secret_planetarium" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "SPRING_DATASOURCE_PASSWORD" = var.spring_password
      "SPRING_DATASOURCE_URL"      = var.spring_url
      "SPRING_DATASOURCE_USERNAME" = var.spring_username
    }
    "kind" = "Secret"
    "metadata" = {
      "name"      = "planetarium-secret"
      "namespace" = "default"
    }
    "type" = "Opaque"
  }
}

## Kubernetes ClusterIP

resource "kubernetes_manifest" "service_planetarium_clusterip" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app" = "planetarium"
        "job" = "planetarium-app"
      }
      "name"      = "planetarium-clusterip"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app"  = "planetarium"
        "role" = "blue"
      }
      "type" = "ClusterIP"
    }
  }
}

## Kubernetes ServiceMonitor

resource "kubernetes_manifest" "servicemonitor_planetarium" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "planetarium-service-monitor"
      "namespace" = "default"
    }
    "spec" = {
      "endpoints" = [
        {
          "interval" = "10s"
          "path"     = "/actuator/prometheus"
          "port"     = "http"
        },
      ]
      "jobLabel" = "job"
      "selector" = {
        "matchLabels" = {
          "app" = "planetarium"
          "job" = "planetarium-app"
        }
      }
    }
  }
}

## Kubernetes Ingress

resource "kubernetes_manifest" "ingress_planetarium" {
  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "Ingress"
    "metadata" = {
      "annotations" = {
        "kubernetes.io/ingress.class"                        = "nginx"
        "nginx.ingress.kubernetes.io/affinity"               = "cookie"
        "nginx.ingress.kubernetes.io/affinity-mode"          = "balanced"
        "nginx.ingress.kubernetes.io/rewrite-target"         = "$1"
        "nginx.ingress.kubernetes.io/session-cookie-expires" = "172800"
        "nginx.ingress.kubernetes.io/session-cookie-max-age" = "172800"
        "nginx.ingress.kubernetes.io/session-cookie-path"    = "/"
        "nginx.ingress.kubernetes.io/use-regex"              = "true"
      }
      "name"      = "planetarium-ingress"
      "namespace" = "default"
    }
    "spec" = {
      "ingressClassName" = "nginx"
      "rules" = [
        {
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "service" = {
                    "name" = "planetarium-clusterip"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path"     = "/planetarium(.+)"
                "pathType" = "Prefix"
              },
              {
                "backend" = {
                  "service" = {
                    "name" = "green-clusterip"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path"     = "/green(.+)"
                "pathType" = "Prefix"
              },
              {
                "backend" = {
                  "service" = {
                    "name" = "blue-clusterip"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path"     = "/blue(.+)"
                "pathType" = "Prefix"
              },
            ]
          }
        },
      ]
    }
  }
}