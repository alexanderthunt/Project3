resource "kubernetes_manifest" "prometheusrule_planetarium_prometheus_rules_appdown" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "planetarium-alerts"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "Planetarium"
          "rules" = [
            {
              "alert" = "AppDown"
              "annotations" = {
                "description" = "Prometheus has detected the application is not running"
                "summary"     = "Planetarium App is down"
              }
              "expr" = "up{job=\"planetarium-app\"} != 1"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="planetarium-app"}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[5m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency:rate5m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="planetarium-app"}[15m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[15m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency:rate15m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="planetarium-app"}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[30m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency:rate30m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="planetarium-app"}[60m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[60m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency:rate60m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="planetarium-app"}[5m])))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency99:rate5m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="planetarium-app"}[15m])))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency99:rate15m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="planetarium-app"}[30m])))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency99:rate30m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="planetarium-app"}[60m])))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "latency99:rate60m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="planetarium-app", outcome!="SERVER_ERROR"}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[5m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "successrate:rate5m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="planetarium-app", outcome!="SERVER_ERROR"}[15m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[15m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "successrate:rate15m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="planetarium-app", outcome!="SERVER_ERROR"}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[30m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "successrate:rate30m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="planetarium-app", outcome!="SERVER_ERROR"}[60m]))
              /
              sum(rate(http_server_requests_seconds_count{job="planetarium-app"}[60m]))
              
              EOT
              "labels" = {
                "job" = "planetarium-app"
              }
              "record" = "successrate:rate60m"
            },
            {
              "alert" = "Spike in CPU Usage"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "Spike in CPU Usage Detected"
              }
              "expr" = "irate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[5m]) > 0.2"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[5m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 10m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[10m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 15m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[15m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 30m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[30m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 60m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}[60m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High memory Usage 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the planetarium applications has High memory usage"
                "summary"     = "High memory Usage Detected"
              }
              "expr" = "sum(container_memory_working_set_bytes{container=\"planetarium\", pod=~\"planetarium-deployment-blue.*\"}) > 1200000000"
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
