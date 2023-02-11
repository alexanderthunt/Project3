## Promtail ConfigMap
resource "kubernetes_manifest" "configmap_blue_promtail" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "promtail.yml" = <<-EOT
      server:
        http_listen_port: 9080
        grpc_listen_port: 0
      positions:
        filename: /tmp/positions.yaml
      clients:
        - url: http://loki:3100/loki/api/v1/push
      scrape_configs:
        - job_name: system
          static_configs:
            - targets:
                - localhost
              labels:
                job: blue-logs
                app: blue # or planetarium
                __path__: /logs/*.log
                namespace: default
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name"      = "blue-promtail"
      "namespace" = "default"
    }
  }
}

## Blue Deployment
resource "kubernetes_manifest" "deployment_planetarium_blue" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "planetarium"
      }
      "name"      = "planetarium-deployment-blue"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 3
      "selector" = {
        "matchLabels" = {
          "app"  = "planetarium"
          "role" = "blue"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app"  = "planetarium"
            "role" = "blue"
          }
        }
        "spec" = {
          "affinity" = {
            "nodeAffinity" = {
              "requiredDuringSchedulingIgnoredDuringExecution" = {
                "nodeSelectorTerms" = [
                  {
                    "matchExpressions" = [
                      {
                        "key"      = "kubernetes.io/hostname"
                        "operator" = "In"
                        "values" = [
                          "ip-10-0-2-30.ec2.internal",
                        ]
                      },
                    ]
                  },
                ]
              }
            }
          }
          "containers" = [
            {
              "envFrom" = [
                {
                  "secretRef" = {
                    "name" = "planetarium-secret"
                  }
                },
              ]
              "image"           = "esuminski/p3planetarium:base"
              "imagePullPolicy" = "Always"
              "name"            = "planetarium"
              "ports" = [
                {
                  "containerPort" = 8080
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/logs"
                  "name"      = "logs"
                },
              ]
            },
            {
              "args" = [
                "-config.file=/etc/promtail/promtail.yml",
              ]
              "image" = "grafana/promtail"
              "name"  = "promtail-container"
              "volumeMounts" = [
                {
                  "mountPath" = "/logs"
                  "name"      = "logs"
                },
                {
                  "mountPath" = "/etc/promtail"
                  "name"      = "blue-promtail"
                },
              ]
            },
          ]
          "tolerations" = [
            {
              "effect"   = "NoSchedule"
              "key"      = "app"
              "operator" = "Equal"
              "value"    = "greenPlanetarium"
            },
            {
              "effect"   = "NoExecute"
              "key"      = "app"
              "operator" = "Equal"
              "value"    = "greenPlanetarium"
            },
          ]
          "volumes" = [
            {
              "name" = "logs"
            },
            {
              "configMap" = {
                "name" = "blue-promtail"
              }
              "name" = "blue-promtail"
            },
          ]
        }
      }
    }
  }
}

## blue ClusterIP
resource "kubernetes_manifest" "service_blue_clusterip" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app"  = "planetarium"
        "job"  = "blue-app"
        "role" = "blue"
      }
      "name"      = "blue-clusterip"
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

## Blue ServiceMonitor
resource "kubernetes_manifest" "servicemonitor_blue" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "blue-service-monitor"
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
          "job" = "blue-app"
        }
      }
    }
  }
}

