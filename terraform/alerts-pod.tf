resource "kubernetes_manifest" "prometheusrule_planetarium_prometheus_rules_podsdown" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "planetarium-prometheus-rules-podsdown"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "PodsDown"
          "rules" = [
            {
              "alert" = "PodNotHealthy"
              "annotations" = {
                "description" = "Pod is in a non-ready state."
                "summary"     = "One or more Pods are not healthy."
              }
              "expr" = "sum by (namespace, pod) (kube_pod_status_phase{phase=~\"Pending|Unknown|Failed\"}) > 0"
              "labels" = {
                "severity" = "critical"
              }
            },
          ]
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "prometheusrule_planetarium_prometheus_rules_pod_restart" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "planetarium-prometheus-rules-pod-restart"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "PodRestart"
          "rules" = [
            {
              "alert" = "PodRestart 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the cluster's pods are consistently restarting"
                "summary"     = "Pods are restarting more than once within 5m interval"
              }
              "expr" = "sum(increase(kube_pod_container_status_restarts_total{namespace=\"default\"}[5m])) > 1"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "PodRestart 15m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the cluster's pods are consistently restarting"
                "summary"     = "Pods are restarting more than once within 15m interval"
              }
              "expr" = "sum(increase(kube_pod_container_status_restarts_total{namespace=\"default\"}[15m])) > 1"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "PodRestart 30m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the cluster's pods are consistently restarting"
                "summary"     = "Pods are restarting more than once within 30m interval"
              }
              "expr" = "sum(increase(kube_pod_container_status_restarts_total{namespace=\"default\"}[30m])) > 1"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "PodRestart 60m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the cluster's pods are consistently restarting"
                "summary"     = "Pods are restarting more than once within 60m interval"
              }
              "expr" = "sum(increase(kube_pod_container_status_restarts_total{namespace=\"default\"}[60m])) > 1"
              "labels" = {
                "severity" = "critical"
              }
            },
          ]
        },
      ]
    }
  }
}
