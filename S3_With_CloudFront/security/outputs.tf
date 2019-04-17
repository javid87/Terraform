#----Security/outputs.tf----
output "ep_cert_name" {
	value = "${aws_acm_certificate.ep_cert.id}"
}
