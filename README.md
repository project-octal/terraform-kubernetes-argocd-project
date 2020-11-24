# terraform-argocd-project
A Terraform module for provisioning ArgoCD projects
 
##### namespace - *required*
The name of the target ArgoCD Namespace

##### name - *required*
The name of this ArgoCD project

##### description - *required*
A description for this ArgoCD project

##### destinations - *optional*
A list of server and namespaces that this project may deploy to.
* Defaults to the `https://kubernetes.default.svc` cluster endpoint and `default` namespace.
**NOTE:** The need to explicitly specify the endpoint and namespace will be removed in later versions through the use of the `optional(...)` modifier.  

##### cascade_delete - *optional*
Set to true if this application should cascade delete.
* Defaults to `false`

##### source_repos - *optional*
A list of repositories this project may pull from.
* Defaults to `["*"]` wich allows applications within this project to pull from any git repos.

##### cluster_resource_whitelist - *optional*
A list of cluster-scoped resources the project is allowed to access.
* Defaults to `[]` which allows the project applications to access all cluster resources.

##### namespace_resource_whitelist - *optional*
A list of namespace-scoped resources the project is allowed to access.
* Defaults to `[]` which allows the project applications to access all namespaced resources.

##### namespace_resource_blacklist - *optional*
A list of namespace-scoped resources the project is **NOT** allowed to access.
* Defaults to `[]`

##### permissions - *optional*
A list of roles and their policies to define within ArgoCD.
* Defaults to `[]` which means only only users with the default read-only or admin roles will have access.

### Example
Example Implementation: https://github.com/rationalhealthcare/terraform-octal-kergiva
```hcl-terraform
# The namespace the project will reside in
resource "kubernetes_namespace" "kergiva_namespace" {
  metadata {
    name = local.instance_name
  }
}

# Create the ArgoCD Project.
module "project" {
  source = "github.com/project-octal/terraform-argocd-project?ref=v1.0.1"

  argocd_namespace = data.terraform_remote_state.infra.outputs.cluster_argocd_namespace
  name             = local.instance_name
  description      = local.project_description
  destinations = [
    {
      server    = "https://kubernetes.default.svc"
      namespace = kubernetes_namespace.kergiva_namespace.metadata.0.name
    }
  ]
  permissions = [
    {
      name = "developer-read-only"
      description = "A read-only role for the developers of Kergiva"
      policies = [
        {
          resource = "applications"
          action = "get"
          object = "*"
        }
      ]
      oidc_groups = [
        "argocd-kergiva-developers"
      ]
    }
  ]
}
```