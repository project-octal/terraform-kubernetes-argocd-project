locals {
  argo_project = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"
    metadata = {
      name      = var.name
      namespace = var.argocd_namespace
    }
    finalizers = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    spec = {
      description                = var.description
      sourceRepos                = var.source_repos
      destinations               = var.destinations
      clusterResourceWhitelist   = var.cluster_resource_whitelist
      namespaceResourceWhitelist = var.namespace_resource_whitelist
      namespaceResourceBlacklist = var.namespace_resource_blacklist
      roles : [ for role in var.roles : { name: role["name"], description: role["description"], policies: role["policies"], groups: var.oidc_group_role_membership[role["name"]] } ]
    }
  }
}