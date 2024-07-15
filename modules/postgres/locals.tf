locals {
  template_string_prefix = "pg_dump -h $${host} -d $${database} -U $${user} --format=$${format} --table"
  template_string_suffix = "--data-only -Fc -f $${mount_point}/$(date +%F)/$${file_name}"
  pg_dump_commands       = [for p in var.postgres_backups.backups : join(" ", [templatestring(local.template_string_prefix, p), "${join(" --table ", p.tables)}", templatestring(local.template_string_suffix, p)])]

  cronjob_command = join(";", [for c in local.pg_dump_commands : c])
  pg_pass         = base64encode(file(var.postgres_pass_file_path))
}