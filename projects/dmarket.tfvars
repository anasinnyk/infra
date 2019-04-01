name                 = "gis"
region               = "us-central1"
project              = "development-199614"
k8s_version          = "1.11.5-gke.5"
instances_cidr       = "10.1.0.0/16"
cloudflare_email     = "A.nasinnyk@globalgames.net"
cloudflare_org_id    = "c063988ebffb9233d24e8b0cdd0f9cf2"
cloudflare_zone      = "dmarket.com"
github_organization  = "suntechsoft"
initial_node_count   = 1
firewall_allow_rules = [
  {
    protocol = "icmp"
    ports    = ""
  },
  {
    protocol = "tcp"
    ports    = "80,443"
  }
]
namespaces           = []
service_accounts     = [
  {
    name                  = "tiller",
    namespace             = "kube-system"
    cluster_role_bindings = "cluster-admin"
  }
]
charts               = [
  {
    name      = "argo"
    chart     = "argo/argo"
    namespace = "argo"
  },
  {
    name      = "atlantis"
    namespace = "atlantis"
  },
  {
    name      = "istio"
    chart     = "istio/istio"
    namespace = "istio-system"
  },
  {
    name      = "argo-events"
    chart     = "./charts/argo-events"
    namespace = "argo"
  },
  {
    name      = "vault"
    chart     = "banzaicloud/vault"
    namespace = "vault"
  },
  {
    name      = "vault-operator"
    chart     = "banzaicloud/vault-operator"
    namespace = "vault"
  },
  {
    name      = "vault-hook"
    chart     = "banzaicloud/vault-secrets-webhook"
    namespace = "vault"
  },
  {
    name = "redis"
  }
]
cloudflare_domains   = [
  "atlantis",
  "argo"
]
github_webhooks = [
  {
    repository   = "infra-provisioning"
    events       = "pull_request,pull_request_review,push,issue_comment"
    url          = "https://atlantis.dmarket.com/events"
    content_type = "json"
  }
]
