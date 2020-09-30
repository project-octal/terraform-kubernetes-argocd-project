resource "k8s_manifest" "argo_project" {
  content = yamlencode(local.argo_project)
}