resource "kubernetes_manifest" "secret_planetarium_secret" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "SPRING_DATASOURCE_PASSWORD" = var.spring_password
      "SPRING_DATASOURCE_URL" = "amRiYzpwb3N0Z3Jlc3FsOi8vcGxhbmV0YXJpdW0uY29rdHBoaGU2ZXZpLnVzLWVhc3QtMi5yZHMuYW1hem9uYXdzLmNvbTo1NDMyL3BsYW5ldGFyaXVt"
      "SPRING_DATASOURCE_USERNAME" = "c2FicmluYQ=="
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "planetarium-secret"
    }
    "type" = "Opaque"
  }
}
