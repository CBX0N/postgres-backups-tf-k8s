variable "backup_schedule" {
  type        = string
  description = "Schedule for Cronjobs to run"
  default     = "59 23 * * *"
}

variable "busybox_version" {
  type        = string
  description = "Version of Rancher BusyBox Container"
  default     = "1.31.1"
}

variable "postgres_version" {
  type        = string
  description = "Version of Postgres Container"
  default     = "16"
}

variable "postgres_backups" {
  type = object({
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
}

variable "postgres_pass_file_path" {
  type = string
}