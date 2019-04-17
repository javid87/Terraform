#----Networking/main.tf----
data "aws_availability_zones" "ep_availability_zones" {}

resource "aws_vpc" "ep_vpc01" {
	cidr_block = "${var.ep_vpc01_cidr}"
	enable_dns_hostnames = true
	enable_dns_support = true
tags {
	Name = "EpamPro_VPC01"
	}
}

resource "aws_internet_gateway" "ep_igw01" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
tags {
	Name = "EpamPro_IGW01"
	}
}

resource "aws_eip" "ep_elastic_ip_natA" {
	vpc = true
	associate_with_private_ip = "${var.ep_elastic_ip_NatA}"
tags {
	Name = "EpamPro_NatA_EIP"
	}
}

resource "aws_eip" "ep_elastic_ip_natB" {
	vpc = true
	associate_with_private_ip = "${var.ep_elastic_ip_NatB}"
tags {
	Name = "EpamPro_NatB_EIP"
	}
}

resource "aws_nat_gateway" "ep_natA" {
	allocation_id = "${aws_eip.ep_elastic_ip_natA.id}"
	subnet_id = "${aws_subnet.ep_public_subnetA.id}"
tags {
	Name = "EpamPro_NatA"
	}
}

resource "aws_nat_gateway" "ep_natB" {
	allocation_id = "${aws_eip.ep_elastic_ip_natB.id}"
	subnet_id = "${aws_subnet.ep_public_subnetB.id}"
tags {
	Name = "EpamPro_NatB"
	}
}

resource "aws_route_table" "ep_public_routeA" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
route {
	cidr_block = "0.0.0.0/0"	
	gateway_id = "${aws_internet_gateway.ep_igw01.id}"
	}
tags {
	Name = "EpamPro_PublicRouteA"
        }	
}

resource "aws_route_table" "ep_public_routeB" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.ep_igw01.id}"
	}
tags {
	Name = "EpamPro_PublicRouteB"
	}
}

resource "aws_route_table" "ep_private_routeA" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_nat_gateway.ep_natA.id}"
	}
tags {
	Name = "EpamPro_PrivateRouteA"
	}
}

resource "aws_route_table" "ep_private_routeB" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_nat_gateway.ep_natB.id}"
	}
tags {
	Name = "EpamPro_PrivateRouteB"
	}
}

resource "aws_default_route_table" "ep_default_route" {
	default_route_table_id = "${aws_vpc.ep_vpc01.default_route_table_id}"
tags {
	Name = "EpamDefaultRoute"
	}
}

resource "aws_subnet" "ep_public_subnetA" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
	cidr_block = "${var.ep_subnetA_cidr}"
	map_public_ip_on_launch = true
	availability_zone = "us-east-1a"
tags	{
	Name = "EpamPro_PublicSubnetA"
	}
}

resource "aws_subnet" "ep_public_subnetB" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
	cidr_block = "${var.ep_subnetB_cidr}"
	map_public_ip_on_launch = true
	availability_zone = "us-east-1b"
tags	{
	Name = "EpamPro_PublicSubnetB"
	}
}

resource "aws_subnet" "ep_private_subnetA" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
	cidr_block = "${var.ep_private_subnetA_cidr}"
	availability_zone = "us-east-1a"
tags	{
	Name = "EpamPro_PrivateSubnetA"
	}
}

resource "aws_subnet" "ep_private_subnetB" {
	vpc_id = "${aws_vpc.ep_vpc01.id}"
	cidr_block = "${var.ep_private_subnetB_cidr}"
	availability_zone = "us-east-1b"
tags	{
	Name = "EpamPro_PrivateSubnetB"
	}
}

resource "aws_route_table_association" "ep_public_routeA_associate" {
	route_table_id = "${aws_route_table.ep_public_routeA.id}"
	subnet_id = "${aws_subnet.ep_public_subnetA.id}"
}

resource "aws_route_table_association" "ep_public_routeB_associate" {
        route_table_id = "${aws_route_table.ep_public_routeB.id}"
        subnet_id = "${aws_subnet.ep_public_subnetB.id}"
}

resource "aws_route_table_association" "ep_private_routeA_associate" {
        route_table_id = "${aws_route_table.ep_private_routeA.id}"
        subnet_id = "${aws_subnet.ep_private_subnetA.id}"
}

resource "aws_route_table_association" "ep_private_routeB_associate" {
        route_table_id = "${aws_route_table.ep_private_routeB.id}"
        subnet_id = "${aws_subnet.ep_private_subnetB.id}"
}

