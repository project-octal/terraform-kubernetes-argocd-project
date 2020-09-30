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
  default = {
    server    = "https://kubernetes.default.svc"
    namespace = "default"
  }
}
variable "cascade_delete" {
  type        = bool
  description = "Set to true if this application should cascade delete"
  default     = false
}
variable "source_repos" {
  type        = list(string)
  description = "A list of repositories this project may pull from"
  default     = "*"
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
variable "roles" {
  type        = list(object({ name : string, description : string, policies : list(string) }))
  description = "A list of roles and their policies to define within ArgoCD"
  default     = []
}
variable "oidc_group_role_membership" {
  type        = map(list(string))#list(object({ group_name : string, roles : list(string) }))
  description = "A map of `roles.*.name` to a list of member OIDC groups"
  #description = "A list of objects that contain a `group_name` and the roles it will be a member of."
  default     = {}
}