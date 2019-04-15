output "Log_Bucket_Name" {
	value = "${module.ep_storage.ep_log_bucket_name}"
}
output "Site_Bucket_Name" {
	value = "${module.ep_storage.ep_www_site}"
}
output "Site_Bucket_ARN" {
	value = "${module.ep_storage.ep_str_arn}"
}
