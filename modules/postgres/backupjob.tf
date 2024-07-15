resource "kubernetes_cron_job_v1" "pg_dump_cron_job" {
  metadata {
    name = "pg-dump-cron-job"
  }
  spec {
    concurrency_policy            = var.postgres_backups.concurrency_policy
    timezone                      = var.postgres_backups.timezone
    schedule                      = var.postgres_backups.schedule == null ? var.backup_schedule : var.postgres_backups.schedule
    suspend                       = var.postgres_backups.suspend
    failed_jobs_history_limit     = var.postgres_backups.failed_jobs_history_limit
    starting_deadline_seconds     = var.postgres_backups.starting_deadline_seconds
    successful_jobs_history_limit = var.postgres_backups.successful_jobs_history_limit
    job_template {
      metadata {}
      spec {
        template {
          metadata {}
          spec {
            volume {
              name = "backups"
              nfs {
                server    = var.postgres_backups.nfs_target
                path      = var.postgres_backups.nfs_path
                read_only = false
              }
            }
            volume {
              name = "postgres-pass"
              secret {
                secret_name  = "pg-pass-secret"
                default_mode = "0600"
              }
            }
            volume {
              name = "pgpass"
              empty_dir {
                size_limit = "1M"
              }
            }
            init_container {
              name              = "init-backup"
              image             = "docker.io/rancher/mirrored-library-busybox:${var.busybox_version}"
              # image_pull_policy = "Never"
              command           = ["/bin/sh"]
              args              = ["-c", "cp /tmp/postgres/pgpass /pg/.pgpass; chmod 0600 /pg/.pgpass; mkdir /backups/$(date +%F)"]

              volume_mount {
                mount_path = "/tmp/postgres"
                name       = "postgres-pass"
                read_only  = true
              }
              volume_mount {
                mount_path = "/pg/"
                name       = "pgpass"
              }
              volume_mount {
                mount_path = "/backups"
                name       = "backups"
              }
            }
            container {
              name              = "postgres-backup"
              image             = "postgres:${var.postgres_version}"
              # image_pull_policy = "Never"
              command           = ["sh", "-c", local.cronjob_command]
              env {
                name  = "PGPASSFILE"
                value = "/pg/.pgpass"
              }
              volume_mount {
                mount_path = "/pg/"
                name       = "pgpass"
                read_only  = true
              }
              volume_mount {
                mount_path = "/backups"
                name       = "backups"
              }
            }
            dynamic "container" {
              for_each = var.postgres_backups.cleanup != false ? ["1"] : []
              content {
                name              = "cleanup-backup"
                image             = "docker.io/rancher/mirrored-library-busybox:${var.busybox_version}"
                # image_pull_policy = "Never"
                command           = ["/bin/sh"]
                args              = ["-c", "rm -R /backups/$( date +%F -d @$(($(date +%s)-${86400 * var.postgres_backups.rention_days})))"]
                volume_mount {
                  mount_path = "/backups"
                  name       = "backups"
                }
              }
            }
          }
        }
      }
    }
  }
}
