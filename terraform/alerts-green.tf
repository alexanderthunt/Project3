resource "kubernetes_manifest" "prometheusrule_green_alerts" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "labels" = {
        "release" = "prometheus"
      }
      "name"      = "green-alerts"
      "namespace" = "default"
    }
    "spec" = {
      "groups" = [
        {
          "name" = "Green"
          "rules" = [
            {
              "alert" = "AppDown"
              "annotations" = {
                "description" = "Prometheus has detected the green application is not running"
                "summary"     = "Green App is down"
              }
              "expr" = "absent(up{job=\"green-app\"}) == 1"
              "labels" = {
                "severity" = "warning"
              }
            },
            {
              "alert" = "Latency 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application latency is over 200ms"
                "summary"     = "Green latency is over 200ms within 5m interval"
              }
              "expr" = <<-EOT
              latency:rate5m{job="green-app"} > .2
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Latency 15m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application latency is over 200ms"
                "summary"     = "Green latency is over 200ms within 15m interval"
              }
              "expr" = <<-EOT
              latency:rate15m{job="green-app"} > .2
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Latency 30m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application latency is over 200ms"
                "summary"     = "Green latency is over 200ms within 30m interval"
              }
              "expr" = <<-EOT
              latency:rate30m{job="green-app"} > .2
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Latency 60m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application latency is over 200ms"
                "summary"     = "Green latency is over 200ms within 60m interval"
              }
              "expr" = <<-EOT
              latency:rate60m{job="green-app"} > .2
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Success Rate 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application success rate is below 99.8%"
                "summary"     = "Green success rate is below 99.8% within 5m interval"
              }
              "expr" = <<-EOT
              successrate:rate5m{job="green-app"} < .998
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Success Rate 15m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application success rate is below 99.8%"
                "summary"     = "Green success rate is below 99.8% within 15m interval"
              }
              "expr" = <<-EOT
              successrate:rate15m{job="green-app"} < .998
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Success Rate 30m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application success rate is below 99.8%"
                "summary"     = "Green success rate is below 99.8% within 30m interval"
              }
              "expr" = <<-EOT
              successrate:rate30m{job="green-app"} < .998
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Success Rate 60m Interval"
              "annotations" = {
                "description" = "Prometheus has detected the green application success rate is below 99.8%"
                "summary"     = "Green success rate is below 99.8% within 60m interval"
              }
              "expr" = <<-EOT
              successrate:rate60m{job="green-app"} < .998
              
              EOT
              "labels" = {
                "job"      = "green-app"
                "severity" = "critical"
              }
            },
            {
              "alert" = "Spike in CPU Usage"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "Spike in CPU Usage Detected"
              }
              "expr" = "irate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[5m]) > 0.2"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 5m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[5m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 10m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[10m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 15m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[15m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 30m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[30m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High CPU Usage 60m Interval"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High CPU usage"
                "summary"     = "High CPU Usage Detected"
              }
              "expr" = "rate(container_cpu_usage_seconds_total{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"}[60m]) > 0.15"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "alert" = "High memory Usage"
              "annotations" = {
                "description" = "Prometheus has detected one of the green app has High memory usage"
                "summary"     = "High memory Usage Detected"
              }
              "expr" = "container_memory_working_set_bytes{container=\"planetarium\", pod=~\"planetarium-deployment-green.*\"} > 400000000"
              "labels" = {
                "severity" = "critical"
              }
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="green-app"}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[5m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency:rate5m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="green-app"}[15m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[15m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency:rate15m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="green-app"}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[30m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency:rate30m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_sum{job="green-app"}[60m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[60m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency:rate60m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="green-app", outcome!="SERVER_ERROR"}[5m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[5m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "successrate:rate5m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="green-app", outcome!="SERVER_ERROR"}[15m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[15m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "successrate:rate15m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="green-app", outcome!="SERVER_ERROR"}[30m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[30m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "successrate:rate30m"
            },
            {
              "expr" = <<-EOT
              sum(rate(http_server_requests_seconds_count{job="green-app", outcome!="SERVER_ERROR"}[60m]))
              /
              sum(rate(http_server_requests_seconds_count{job="green-app"}[60m]))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "successrate:rate60m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="green-app"}[5m])))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency99:rate5m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="green-app"}[15m])))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency99:rate15m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="green-app"}[30m])))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency99:rate30m"
            },
            {
              "expr" = <<-EOT
              histogram_quantile(0.99, sum by(le) (rate(http_server_requests_seconds_bucket{job="green-app"}[60m])))
              
              EOT
              "labels" = {
                "job" = "green-app"
              }
              "record" = "latency99:rate60m"
            },
          ]
        },
      ]
    }
  }
}
