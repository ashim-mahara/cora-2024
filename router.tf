resource "openstack_networking_router_v2" "router" {
  name           = "router"
  admin_state_up = "true"
  external_network_id = "418d945b-4e96-4be5-b81e-9cb857f2f64b"
}

resource "openstack_networking_network_v2" "business_network"{
  name = "business_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "control_room_network"{
  name = "control_room_network"
  admin_state_up = "true"
}

# subnet pool for the whole of internal network
# consists of the Business LAN, Enterprise LAN, Control System LAN, SOC/Monitoring LAN
resource "openstack_networking_subnetpool_v2" "internalNetworkPool" {
  name = "internalNetworkPool"
  prefixes = ["10.0.0.0/8"]
}

resource "openstack_networking_subnet_v2" "business_lan" {
  name          = "business_lan"
  cidr          = "10.10.0.0/16"
  network_id    = openstack_networking_network_v2.business_network.id
  subnetpool_id = openstack_networking_subnetpool_v2.internalNetworkPool.id
}

resource "openstack_networking_router_interface_v2" "router_business_lan_interface"{
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.business_lan.id
}

resource "openstack_networking_subnet_v2" "control_room_lan" {
  name          = "control_room_lan"
  cidr          = "10.100.0.0/16"
  network_id    = openstack_networking_network_v2.control_room_network.id
  subnetpool_id = openstack_networking_subnetpool_v2.internalNetworkPool.id
}

resource "openstack_networking_router_interface_v2" "router_control_room_lan_interface"{
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.control_room_lan.id
}
