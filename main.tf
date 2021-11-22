resource "kubernetes_manifest" "argo_project" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"
    metadata = {
      name      = var.name
      namespace = var.namespace
      finalizers = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    }
    spec = {
      description                = var.description
      sourceRepos                = var.source_repos
      destinations               = var.destinations
      clusterResourceWhitelist   = var.cluster_resource_whitelist
      namespaceResourceWhitelist = var.namespace_resource_whitelist
      namespaceResourceBlacklist = var.namespace_resource_blacklist
      roles : [
        for permission in var.permissions : {
          name : permission["name"],
          description : permission["description"],
          policies : [
            for policy in permission["policies"] :
            "p, proj:${var.name}:${permission["name"]}, ${policy["resource"]}, ${policy["action"]}, ${var.name}/${policy["object"]}, allow"
          ],
          groups : permission["oidc_groups"]
        }
      ]
    }
  }
}