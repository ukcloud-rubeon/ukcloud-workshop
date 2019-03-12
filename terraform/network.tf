data "openstack_networking_network_v2" "internet" {
    name = "internet"
}

# router
resource "openstack_networking_router_v2" "router" {
        name = "router"
        external_network_id = "${data.openstack_networking_network_v2.internet.id}"
}
# networks
resource "openstack_networking_network_v2" "dmz" {
    name = "network_dmz"
}

resource "openstack_networking_network_v2" "app" {
    name = "network_app"
}
# subnets
resource "openstack_networking_subnet_v2" "dmz" {
    name = "subnet_dmz"
    cidr = "${var.cidr["dmz"]}"
    network_id = "${openstack_networking_network_v2.dmz.id}"

}


resource "openstack_networking_subnet_v2" "app" {
    name = "subnet_app"
    network_id = "${openstack_networking_network_v2.app.id}"
    cidr = "${var.cidr["app"]}"
}

# router interfaces

resource "openstack_networking_router_interface_v2" "router_dmz" {
    router_id = "${openstack_networking_router_v2.router.id}"
    subnet_id = "${openstack_networking_subnet_v2.dmz.id}"
}

resource "openstack_networking_router_interface_v2" "router_app" {
    router_id = "${openstack_networking_router_v2.router.id}"
    subnet_id = "${openstack_networking_subnet_v2.app.id}"
}

# floating IP addresses
# resource "openstack_compute_floatingip_v2" "float_1" {
#
# }
#
# resource "openstack_compute_floatingip_v2" "float_2" {
#
# }
# # security groups
#
resource "openstack_networking_secgroup_v2" "dmz" {
    name = "sg-dmz"
}
#

#
resource "openstack_networking_secgroup_v2" "app" {
    name = "sg-app"
}


#
resource "openstack_networking_secgroup_rule_v2" "dmz" {
    count = "${length(var.allowed_ports_dmz)}"
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    port_range_min = "${var.allowed_ports_dmz[count.index]}"
    port_range_max = "${var.allowed_ports_dmz[count.index]}"
    remote_ip_prefix = "0.0.0.0/0"
    security_group_id = "${openstack_networking_secgroup_v2.dmz.id}"
}
#
resource "openstack_networking_secgroup_rule_v2" "app" {
    count = "${length(var.allowed_ports_app)}"
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    port_range_min = "${var.allowed_ports_dmz[count.index]}"
    port_range_max = "${var.allowed_ports_dmz[count.index]}"
    remote_group_id = "${openstack_networking_secgroup_v2.dmz.id}"
    security_group_id = "${openstack_networking_secgroup_v2.app.id}"
}
