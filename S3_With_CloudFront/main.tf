#----S3_With_CloudFront-root-main.tf----
provider "aws" "ep_aws" {
	region = "us-east-1"
}

#Storage Module
module "ep_storage" {
	source = "./storage"
	ep_bucket_name = "${var.ep_bucket}"
}

#Security Module
module "ep_security" {
	source = "./security"
	ep_www_site_id = "${module.ep_storage.ep_www_site}"
	ep_str_id = "${module.ep_storage.ep_www_site}"
	ep_str_arn = "${module.ep_storage.ep_str_arn}"
	ep_bucket_policy_path = "${var.ep_bucket_policy_path}"
}
