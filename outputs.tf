output "name" {
  depends_on = [
    kubernetes_manifest.argo_project
  ]
  value = var.name
}