#----VPC and EC2 root/outputs.tf----
output "ep_vpc01_id" {
	value = "${module.ep_networking.ep_vpc01_id}"
}

output "ep_vpc_cidr_block" {
    value = "${module.ep_networking.ep_vpc_cidr_block}"
}

output "ep_public_subnetA" {
    value = "${module.ep_networking.ep_public_subnetA}"
}

output "ep_public_subnetB" {
    value = "${module.ep_networking.ep_public_subnetB}"
}

output "ep_private_routeA" {
    value = "${module.ep_networking.ep_private_routeA}"
}

output "ep_private_routeB" {
    value = "${module.ep_networking.ep_private_routeB}"
}