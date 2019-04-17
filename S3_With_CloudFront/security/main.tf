#----Security/main.tf----
resource "aws_cloudfront_origin_access_identity" "ep_origin_access_identity" {
  comment = "EpamPro cloudfront origin access identity"
}

resource "aws_cloudfront_distribution" "ep_website_cdn" {
  enabled      = true
  price_class  = "PriceClass_200"
  http_version = "http1.1"
  aliases = ["${var.ep_www_site_id}","www.${var.ep_www_site_id}"]

  origin {
    origin_id   = "origin-bucket-${var.ep_str_id}"
    domain_name = "${var.ep_www_site_id}.s3.amazonaws.com"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.ep_origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "origin-bucket-${var.ep_str_id}"

    min_ttl          = "0"
    default_ttl      = "300"                                              //3600
    max_ttl          = "1200"                                             //86400

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "BY", "AZ", "KZ"]
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${aws_acm_certificate.ep_cert.arn}"
    ssl_support_method       = "sni-only"
  }

tags = {
  Environment = "production"
	}
}

data "template_file" "ep_bucket_policy" {
  template = "${file(var.ep_bucket_policy_path)}"
  vars {
    origin_access_identity_arn = "${aws_cloudfront_origin_access_identity.ep_origin_access_identity.cloudfront_access_identity_path}"
    bucket = "${var.ep_str_arn}"
  }
}



resource "aws_acm_certificate" "ep_cert" {
  domain_name       = "epam.pro"
  subject_alternative_names = ["*.epam.pro"]
  validation_method = "DNS"

  tags = {
    Environment = "Prod"
    Name = "epam.pro"
    terraform = "true"
    
  }

  lifecycle {
    create_before_destroy = true
  }
}
