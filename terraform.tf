terraform {
  backend "kubernetes" {
    namespace     = "terraform"
    secret_suffix = "vmbackup-state"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }
  required_version = "~>1.9.0"
}