#----Storage/main.tf----
resource "random_id" "str_id" {
	byte_length = 2
}

resource "aws_s3_bucket" "ep_s3" {
	bucket = "${var.ep_bucket_name}-${random_id.str_id.dec}"
	acl = "log-delivery-write"
	force_destroy = true
tags {
	Name = "EpamPro_Log_Bucket"
	}
}

resource "aws_s3_bucket" "ep_www_site" {
  bucket = "${var.ep_bucket_name}"

  logging {
    target_bucket = "${aws_s3_bucket.ep_s3.bucket}"
    target_prefix = "${var.ep_bucket_name}/"
  }

  website {
    index_document = "index.html"
  }
  force_destroy = true
tags {
	Name = "EpamPro_Site_Data"
	}
}

#resource "aws_s3_bucket_object" "ep_object" {
##  bucket = "your_bucket_name"
#  key    = "new_object_key"
#  source = "ep_data/index.html"
#}
resource "null_resource" "ep_upload_to_s3" {
	provisioner "local-exec" {
	command = "aws s3 sync ${path.module}/ep_data s3://${aws_s3_bucket.ep_www_site.id}"
	}
}
