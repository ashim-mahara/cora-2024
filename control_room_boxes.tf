resource "openstack_networking_port_v2" "ubuntu_port_control_room_1" {
  name               = "ubuntu_port_control_room_1"
  network_id         = openstack_networking_network_v2.control_room_network.id
  admin_state_up     = "true"
  security_group_ids = [openstack_networking_secgroup_v2.control_room_ports_group.id]

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.control_room_lan.id
    ip_address = "10.100.30.10"
  }
}

resource "openstack_blockstorage_volume_v3" "ubuntu_volume_control_room_1" {
  name        = "ubuntu_volume_1"
  description = "Volume attached to Ubuntu instance 1"
  size        = 20
  image_id    = data.openstack_images_image_v2.boot_image.id
}

resource "openstack_compute_instance_v2" "ubuntu_instance_control_room_1" {
  name              = "ubuntu_instance_control_room_1"
  image_name        = data.openstack_images_image_v2.boot_image.name
  flavor_name       = "l3-large"

  network {
    port = openstack_networking_port_v2.ubuntu_port_control_room_1.id
  }

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.ubuntu_volume_control_room_1.id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  key_pair = openstack_compute_keypair_v2.djchicken.name
}

resource "openstack_networking_port_v2" "ubuntu_port_control_room_2" {
  name               = "ubuntu_port_control_room_2"
  network_id         = openstack_networking_network_v2.control_room_network.id
  admin_state_up     = "true"
  security_group_ids = [openstack_networking_secgroup_v2.scoring_box_group.id]

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.control_room_lan.id
    ip_address = "10.100.30.20"
  }
}

resource "openstack_blockstorage_volume_v3" "ubuntu_volume_control_room_2" {
  name        = "ubuntu_volume_2"
  description = "Volume attached to Ubuntu instance 2"
  size        = 20
  image_id    = data.openstack_images_image_v2.boot_image.id
}


resource "openstack_compute_instance_v2" "ubuntu_instance_control_room_2" {
  name              = "ubuntu_instance_control_room_2"
  image_name        = data.openstack_images_image_v2.boot_image.name
  flavor_name       = "l3-large"

  network {
    port = openstack_networking_port_v2.ubuntu_port_control_room_2.id
  }

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.ubuntu_volume_control_room_2.id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  key_pair = openstack_compute_keypair_v2.djchicken.name
}

resource "openstack_networking_floatingip_v2" "floatip" {
  pool = "RIT WAN"
}

resource "openstack_compute_floatingip_associate_v2" "floatip" {
  floating_ip = openstack_networking_floatingip_v2.floatip.address
  instance_id = openstack_compute_instance_v2.ubuntu_instance_control_room_2.id
}
