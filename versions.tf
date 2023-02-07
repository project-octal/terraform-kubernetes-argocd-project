terraform {
  required_version = ">= 0.14.8, < 2.0.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.6.1, <3.0.0"
    }
  }
}
