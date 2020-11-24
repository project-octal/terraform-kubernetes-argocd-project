variable "argocd_namespace" {
  type        = string
  description = "The name of the target ArgoCD Namespace"
}
variable "name" {
  type        = string
  description = "The name for this ArgoCD project"
}
variable "description" {
  type        = string
  description = "A description for this ArgoCD project"
}
variable "destinations" {
  type        = list(object({ server : string, namespace : string }))
  description = "A list of server and namespaces that this project may deploy to."
  default = [{
    server    = "https://kubernetes.default.svc"
    namespace = "default"
  }]
}
variable "cascade_delete" {
  type        = bool
  description = "Set to true if this application should cascade delete"
  default     = false
}
variable "source_repos" {
  type        = list(string)
  description = "A list of repositories this project may pull from"
  default     = ["*"]
}
variable "cluster_resource_whitelist" {
  type        = list(object({ kind : string, group : string }))
  description = "A list of cluster-scoped resources the project is allowed to access"
  default     = []
}
variable "namespace_resource_whitelist" {
  type        = list(object({ kind : string, group : string }))
  description = "A list of namespace-scoped resources the project is allowed to access"
  default     = []
}
variable "namespace_resource_blacklist" {
  type        = list(object({ kind : string, group : string }))
  description = "A list of namespace-scoped resources the project is NOT allowed to access"
  default     = []
}
variable "permissions" {
  type = list(object({
    name : string
    description : string
    policies : list(object({
      resource : string
      action : string
      object : string
    }))
    oidc_groups : list(string)
  }))
  description = "A list of roles and their policies to define within ArgoCD"
  default     = []
}