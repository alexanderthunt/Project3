resource "kubernetes_manifest" "deployment_planetarium_blue" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "planetarium"
      }
      "name" = "planetarium-deployment-blue"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "planetarium"
          "role" = "blue"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "planetarium"
            "role" = "blue"
          }
        }
        "spec" = {
          "containers" = [
            {
              "envFrom" = [
                {
                  "secretRef" = {
                    "name" = "planetarium-secret"
                  }
                },
              ]
              "image" = "esuminski/p3planetarium:base"
              "imagePullPolicy" = "Always"
              "name" = "planetarium"
              "ports" = [
                {
                  "containerPort" = 8080
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/logs"
                  "name" = "logs"
                },
              ]
            },
            {
              "args" = [
                "-config.file=/etc/promtail/promtail.yml",
              ]
              "image" = "grafana/promtail"
              "name" = "promtail-container"
              "volumeMounts" = [
                {
                  "mountPath" = "/logs"
                  "name" = "logs"
                },
                {
                  "mountPath" = "/etc/promtail"
                  "name" = "blue-promtail"
                },
              ]
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
