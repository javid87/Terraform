output "ep_log_bucket_name" {
	value = "${aws_s3_bucket.ep_s3.id}"
}
output "ep_www_site" {
	value = "${aws_s3_bucket.ep_www_site.id}"
}

output "ep_str_arn" {
	value = "${aws_s3_bucket.ep_www_site.arn}"
}
