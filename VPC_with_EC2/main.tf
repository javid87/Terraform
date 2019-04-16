#----VPC and EC2 root/main.tf----
provider "aws" {
	region = "us-east-1"
}
#----networking----
module "ep_networking" {
	source = "./networking"
	ep_vpc01_cidr = "${var.ep_vpc01_cidr}"
	ep_elastic_ip_NatA = "${var.ep_elastic_ip_NatA}"
	ep_elastic_ip_NatB = "${var.ep_elastic_ip_NatB}"
	ep_subnetA_cidr = "${var.ep_subnetA_cidr}"
	ep_subnetB_cidr = "${var.ep_subnetB_cidr}"
	ep_private_subnetA_cidr = "${var.ep_private_subnetA_cidr}"
	ep_private_subnetB_cidr = "${var.ep_private_subnetB_cidr}"
}
