data "openstack_images_image_v2" "ubuntu" {
    name = "${var.ubuntu[var.cloud_name]}"
    most_recent = "true"
}

data "openstack_compute_flavor_v2" "small" {
    name = "t1.medium"
}


data "openstack_compute_flavor_v2" "medium" {
    name = "m1.small"
}


data "openstack_compute_flavor_v2" "large" {
    name = "m1.medium"
}

resource "openstack_compute_instance_v2" "proxy" {
    count = 2
    image_id = "${data.openstack_images_image_v2.ubuntu.id}"
    # image_name = "centos72"
    name = "${format("proxy-%02d", count.index+1)}" # proxy-01, proxy-02

    flavor_id = "${data.openstack_compute_flavor_v2.small.id}"

    metadata {
        groups = "haproxy-demo,proxy"
    }

    network {
        name = "${openstack_networking_network_v2.dmz.name}"
    }

    depends_on = [
        "openstack_networking_subnet_v2.dmz"
    ]
}

resource "openstack_compute_instance_v2" "app" {
    count = 2
    image_id = "${data.openstack_images_image_v2.ubuntu.id}"
    # image_name="centos72"
    name = "${format("app-%02d", count.index+1)}"

    flavor_id = "${data.openstack_compute_flavor_v2.medium.id}"

    metadata {
        groups = "haproxy-demo,app"
    }

    network {
        name = "${openstack_networking_network_v2.app.name}"
    }

    depends_on = [
        "openstack_networking_subnet_v2.app"
    ]

}
