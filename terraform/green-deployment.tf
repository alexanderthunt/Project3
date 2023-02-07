# resource "kubernetes_manifest" "deployment_planetarium_green" {
#   manifest = {
#     "apiVersion" = "apps/v1"
#     "kind"       = "Deployment"
#     "metadata" = {
#       "labels" = {
#         "app" = "planetarium"
#       }
#       "name"      = "planetarium-deployment-green"
#       "namespace" = "default"
#     }
#     "spec" = {
#       "replicas" = 1
#       "selector" = {
#         "matchLabels" = {
#           "app"  = "planetarium"
#           "role" = "green"
#         }
#       }
#       "template" = {
#         "metadata" = {
#           "labels" = {
#             "app"  = "planetarium"
#             "role" = "green"
#           }
#         }
#         "spec" = {
#           "affinity" = {
#             "nodeAffinity" = {
#               "requiredDuringSchedulingIgnoredDuringExecution" = {
#                 "nodeSelectorTerms" = [
#                   {
#                     "matchExpressions" = [
#                       {
#                         "key"      = "kubernetes.io/hostname"
#                         "operator" = "In"
#                         "values" = [
#                           "ip-10-0-2-30.ec2.internal",
#                         ]
#                       },
#                     ]
#                   },
#                 ]
#               }
#             }
#           }
#           "containers" = [
#             {
#               "envFrom" = [
#                 {
#                   "secretRef" = {
#                     "name" = "planetarium-secret"
#                   }
#                 },
#               ]
#               "image"           = "sabrinasmith/planetarium:incident4"
#               "imagePullPolicy" = "Always"
#               "name"            = "planetarium"
#               "ports" = [
#                 {
#                   "containerPort" = 8080
#                 },
#               ]
#               "volumeMounts" = [
#                 {
#                   "mountPath" = "/logs"
#                   "name"      = "logs"
#                 },
#               ]
#             },
#             {
#               "args" = [
#                 "-config.file=/etc/promtail/promtail.yml",
#               ]
#               "image" = "grafana/promtail"
#               "name"  = "promtail-container"
#               "volumeMounts" = [
#                 {
#                   "mountPath" = "/logs"
#                   "name"      = "logs"
#                 },
#                 {
#                   "mountPath" = "/etc/promtail"
#                   "name"      = "green-promtail"
#                 },
#               ]
#             },
#           ]
#           "tolerations" = [
#             {
#               "effect"   = "NoSchedule"
#               "key"      = "app"
#               "operator" = "Equal"
#               "value"    = "greenPlanetarium"
#             },
#             {
#               "effect"   = "NoExecute"
#               "key"      = "app"
#               "operator" = "Equal"
#               "value"    = "greenPlanetarium"
#             },
#           ]
#           "volumes" = [
#             {
#               "name" = "logs"
#             },
#             {
#               "configMap" = {
#                 "name" = "green-promtail"
#               }
#               "name" = "green-promtail"
#             },
#           ]
#         }
#       }
#     }
#   }
# }
