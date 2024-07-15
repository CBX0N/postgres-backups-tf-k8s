postgres_pass_file_path = "./environment/dev/.pgpass"
postgres_backups = {
  nfs_target = "192.168.1.40"
  nfs_path   = "/backups/postgres"
  backups = {
    users = {
      host        = "192.168.1.86"
      user        = "dev"
      tables      = ["user"]
      mount_point = "/backups"
      file_name   = "users.tar"
    }
  }
}