resource "openstack_networking_port_v2" "ubuntu_port" {
  count              = 17
  name               = "ubuntu_port_${count.index + 1}"
  network_id         = openstack_networking_network_v2.business_network.id
  admin_state_up     = "true"
  # security_group_ids = [openstack_networking_secgroup_v2.default.id]

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.business_lan.id
    ip_address = "10.10.10.${20 + count.index}"
  }
}

resource "openstack_blockstorage_volume_v3" "ubuntu_volume" {
  count       = 17
  name        = "ubuntu_volume_${count.index + 1}"
  description = "Volume attached to Ubuntu instance ${count.index + 1}"
  size        = 20
  image_id    = data.openstack_images_image_v2.boot_image.id
}


resource "openstack_compute_instance_v2" "ubuntu_instance" {
  count             = 17
  name              = "ubuntu_instance_${count.index + 1}"
  image_name        = data.openstack_images_image_v2.boot_image.name
  flavor_name       = "l3-medium"

  network {
    port = openstack_networking_port_v2.ubuntu_port[count.index].id
  }

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.ubuntu_volume[count.index].id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  key_pair = openstack_compute_keypair_v2.djchicken.name

}