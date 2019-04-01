data "template_file" "infra-values" {
  template = "${file("./charts/infra/values.yaml")}"
  vars {
    project             = "${var.project}"
    region              = "${var.region}"
    ip_address          = "${google_compute_address.ip_address.address}"
    address_name        = "${google_compute_address.ip_address.name}"
    secret              = "${random_string.secret.result}"
  }
}

resource "helm_release" "infra" {
  name      = "infra"
  chart     = "./charts/infra"
  values    = [
    "${data.template_file.infra-values.*.rendered}"
  ]
  depends_on = ["helm_release.charts"]
}
