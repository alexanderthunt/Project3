resource "kubernetes_manifest" "prometheusrule_error_budget_burn" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "error-budget-burn"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "SLOs-http_server_requests_seconds_count"
          "rules" = [
            {
              "alert" = "ErrorBudgetBurn 2 Days window"
              "annotations" = {
                "description" = "Failure rate of 2.88 or higher"
                "message"     = "High error budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "2% error budget consumption every 1 hour"
              }
              "expr" = <<-EOT
              http_server_requests_seconds_count:burnrate5m > (14.4 * 0.2)
              and
              http_server_requests_seconds_count:burnrate1h > (14.4 * 0.2)
              
              EOT
              "for"  = "2m"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "ErrorBudgetBurn 5 Days window"
              "annotations" = {
                "description" = "Failure rate of 1.2 or higher"
                "message"     = "High error budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "5% error budget consumption every 6 hours"
              }
              "expr" = <<-EOT
              http_server_requests_seconds_count:burnrate30m > (6 * 0.2)
              and
              http_server_requests_seconds_count:burnrate6h > (6 * 0.2)
              
              EOT
              "for"  = "15m"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "ErrorBudgetBurn 10 Days window"
              "annotations" = {
                "description" = "Failure rate of 0.6 or higher"
                "message"     = "High error budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "10% error budget consumption every 1 day"
              }
              "expr" = <<-EOT
              http_server_requests_seconds_count:burnrate2h > (3 * 0.2)
              and
              http_server_requests_seconds_count:burnrate1d > (3 * 0.2)
              
              EOT
              "for"  = "1h"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "warning"
              }
            },
            {
              "alert" = "ErrorBudgetBurn 30 Days window"
              "annotations" = {
                "description" = "Failure rate of 0.2 or higher"
                "message"     = "High error budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "10% error budget consumption every 3 days"
              }
              "expr" = <<-EOT
              http_server_requests_seconds_count:burnrate6h > (1 * 0.2)
              and
              http_server_requests_seconds_count:burnrate3d > (1 * 0.2)
              
              EOT
              "for"  = "3h"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "warning"
              }
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[5m]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate5m"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[30m]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate30m"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[1h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[1h]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate1h"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[2h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[2h]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate2h"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[6h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[6h]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate6h"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[1d]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[1d]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate1d"
            },
            {
              "expr" = <<-EOT
              (
              sum(rate(http_server_requests_seconds_count{job="planetarium-app",status=~"5.."}[3d]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[3d]))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "http_server_requests_seconds_count:burnrate3d"
            },
          ]
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "prometheusrule_latency_budget_burn" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "latency-budget-burn"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "SLOs-http_server_requests_seconds"
          "rules" = [
            {
              "alert" = "LatencyBudgetBurn 2 Days window"
              "annotations" = {
                "description" = "Failure rate of 2.88 or higher"
                "message"     = "High requests latency budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "2% error budget consumption every 1 hour"
              }
              "expr" = <<-EOT
              latencytarget:http_server_requests_seconds:rate5m > (14.4 * 0.2)
              and
              latencytarget:http_server_requests_seconds:rate1h > (14.4 * 0.2)
              
              EOT
              "for"  = "2m"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "LatencyBudgetBurn 5 Days window"
              "annotations" = {
                "description" = "Failure rate of 1.2 or higher"
                "message"     = "High requests latency budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "5% error budget consumption every 6 hours"
              }
              "expr" = <<-EOT
              latencytarget:http_server_requests_seconds:rate30m > (6 * 0.2)
              and
              latencytarget:http_server_requests_seconds:rate6h > (6 * 0.2)
              
              EOT
              "for"  = "15m"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "LatencyBudgetBurn 10 Days window"
              "annotations" = {
                "description" = "Failure rate of 0.6 or higher"
                "message"     = "High requests latency budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "10% error budget consumption every 1 day"
              }
              "expr" = <<-EOT
              latencytarget:http_server_requests_seconds:rate2h > (3 * 0.2)
              and
              latencytarget:http_server_requests_seconds:rate1d > (3 * 0.2)
              
              EOT
              "for"  = "1h"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "warning"
              }
            },
            {
              "alert" = "LatencyBudgetBurn 30 Days window"
              "annotations" = {
                "description" = "Failure rate of 0.2 or higher"
                "message"     = "High requests latency budget burn for job=planetarium-app (current value: {{ $value }})"
                "summary"     = "10% error budget consumption every 3 days"
              }
              "expr" = <<-EOT
              latencytarget:http_server_requests_seconds:rate6h > (1 * 0.2)
              and
              latencytarget:http_server_requests_seconds:rate3d > (1 * 0.2)
              
              EOT
              "for"  = "3h"
              "labels" = {
                "job"      = "planetarium-app"
                "severity" = "warning"
              }
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[5m])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate5m"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[30m])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate30m"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[1h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[1h])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate1h"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[2h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[2h])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate2h"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[6h]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[6h])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate6h"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[1d]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[1d])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate1d"
            },
            {
              "expr" = <<-EOT
              (
              1 - (
              sum(rate(http_server_requests_seconds_bucket{job="planetarium-app", code!~"5..", le="0.20132659"}[3d]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[3d])))
              ) * 100
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latencytarget:http_server_requests_seconds:rate3d"
            },
          ]
        },
      ]
    }
  }
}
