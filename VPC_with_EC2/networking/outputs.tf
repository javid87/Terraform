#----Networking/outputs.tf----
output "ep_vpc01_id" {
	value = "${aws_vpc.ep_vpc01.id}"
}

output "ep_vpc_cidr_block" {
    value = "${aws_vpc.ep_vpc01.cidr_block}"
}

output "ep_public_subnetA" {
    value = "${aws_subnet.ep_public_subnetA.id}"
}

output "ep_public_subnetB" {
    value = "${aws_subnet.ep_public_subnetB.id}"
}

output "ep_private_routeA" {
    value = "${aws_subnet.ep_private_subnetA.id}"
}

output "ep_private_routeB" {
    value = "${aws_subnet.ep_private_subnetB.id}"
}