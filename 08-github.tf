provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

resource "random_string" "secret" {
  length = 16
}

resource "github_repository_webhook" "webhook" {
  count         = "${length(var.github_webhooks)}"
  repository    = "${lookup(var.github_webhooks[count.index], "repository")}"
  name          = "${lookup(var.github_webhooks[count.index], "type", "web")}"
  configuration = {
    url          = "${lookup(var.github_webhooks[count.index], "url")}"
    content_type = "${lookup(var.github_webhooks[count.index], "content_type", "json")}"
    insecure_ssl = "${lookup(var.github_webhooks[count.index], "insecure_ssl", 0)}"
    secret       = "${random_string.secret.result}"
  }
  events         = "${split(",", lookup(var.github_webhooks[count.index], "events"))}"
  depends_on = ["random_string.secret"]
}
