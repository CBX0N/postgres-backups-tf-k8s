module "postgres" {
  source                  = "./modules/postgres"
  backup_schedule         = var.backup_schedule
  postgres_backups        = var.postgres_backups
  postgres_pass_file_path = var.postgres_pass_file_path
}