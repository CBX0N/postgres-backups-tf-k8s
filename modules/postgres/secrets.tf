resource "kubernetes_secret_v1" "pg_pg_pass_secret" {
  metadata {
    name = "pg-pass-secret"
  }

  binary_data = {
    pgpass = local.pg_pass
  }
  type = "Opqaue"
}