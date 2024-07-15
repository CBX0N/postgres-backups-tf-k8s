<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~>1.9.0)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (~>2.30.0)

## Providers

The following providers are used by this module:

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (~>2.30.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [kubernetes_cron_job_v1.pg_dump_cron_job](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) (resource)
- [kubernetes_secret_v1.pg_pg_pass_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_postgres_backups"></a> [postgres\_backups](#input\_postgres\_backups)

Description: n/a

Type:

```hcl
object({
    suspend                       = optional(bool, false)
    concurrency_policy            = optional(string, "Replace")
    timezone                      = optional(string, "Etc/UTC")
    schedule                      = optional(string)
    failed_jobs_history_limit     = optional(number, 5)
    starting_deadline_seconds     = optional(number, 10)
    successful_jobs_history_limit = optional(number, 10)
    rention_days                  = optional(number, 7)
    cleanup                       = optional(bool, true)
    nfs_target                    = string
    nfs_path                      = string
    backups = map(object({
      host        = string
      database    = optional(string, "postgres")
      user        = string
      format      = optional(string, "tar")
      tables      = list(string)
      mount_point = string
      file_name   = string
  })) })
```

### <a name="input_postgres_pass_file_path"></a> [postgres\_pass\_file\_path](#input\_postgres\_pass\_file\_path)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule)

Description: Schedule for Cronjobs to run

Type: `string`

Default: `"59 23 * * *"`

### <a name="input_busybox_version"></a> [busybox\_version](#input\_busybox\_version)

Description: Version of Rancher BusyBox Container

Type: `string`

Default: `"1.31.1"`

### <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version)

Description: Version of Postgres Container

Type: `string`

Default: `"16"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->