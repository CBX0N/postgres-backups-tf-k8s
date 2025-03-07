# postgres-backups-tf-k8s

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ./modules/postgres | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | Schedule for Cronjobs to run | `string` | `"59 23 * * *"` | no |
| <a name="input_postgres_backups"></a> [postgres\_backups](#input\_postgres\_backups) | n/a | <pre>object({<br>    suspend                       = optional(bool, false)<br>    concurrency_policy            = optional(string, "Replace")<br>    timezone                      = optional(string, "Etc/UTC")<br>    schedule                      = optional(string)<br>    failed_jobs_history_limit     = optional(number, 5)<br>    starting_deadline_seconds     = optional(number, 10)<br>    successful_jobs_history_limit = optional(number, 10)<br>    rention_days                  = optional(number, 7)<br>    cleanup                       = optional(bool, true)<br>    nfs_target                    = string<br>    nfs_path                      = string<br>    backups = map(object({<br>      host        = string<br>      database    = optional(string, "postgres")<br>      user        = string<br>      format      = optional(string, "tar")<br>      tables      = list(string)<br>      mount_point = string<br>      file_name   = string<br>  })) })</pre> | n/a | yes |
| <a name="input_postgres_pass_file_path"></a> [postgres\_pass\_file\_path](#input\_postgres\_pass\_file\_path) | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->