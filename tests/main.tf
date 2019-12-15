provider "helm" {
  service_account = "tiller"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.16.1"
}

data "helm_repository" "elastic" {
  name = "elastic"
  url  = "https://helm.elastic.co"
}

resource "helm_release" "elastic" {
  name       = "elastic"
  repository = data.helm_repository.elastic.metadata[0].name
  chart      = "elasticsearch"
  namespace  = "cna-system"

#   version    = "7.5.0"
#   disable_webhooks = true

  set_string {
    name  = "antiAffinity"
    value = "soft"
  }

  set_string {
    name  = "replicas"
    value = "2"
  }
}