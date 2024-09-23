########################## Control Room Ports ###############################

resource "openstack_networking_secgroup_v2" "control_room_ports_group" {
  name        = "control_room_ports_group"
  description = "Security Group for Control Room"
}

# Allow WinRM on Windows Machines
resource "openstack_networking_secgroup_rule_v2" "allow_80_tcp" {
  security_group_id = openstack_networking_secgroup_v2.control_room_ports_group.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = 80
  port_range_max    = 80
}

resource "openstack_networking_secgroup_rule_v2" "allow_443_tcp" {
  security_group_id = openstack_networking_secgroup_v2.control_room_ports_group.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/32"
  port_range_min    = 443
  port_range_max    = 443
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh_tcp_control_room_1" {
  security_group_id =  openstack_networking_secgroup_v2.control_room_ports_group.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = 22
  port_range_max    = 22
}



########################## Allow Scoring Input ###############################

resource "openstack_networking_secgroup_v2" "scoring_box_group" {
  name        = "scoring_box_group"
  description = "Security Group for Control Room"
}

# Allow WinRM on Windows Machines
resource "openstack_networking_secgroup_rule_v2" "allow_51820_tcp" {
  security_group_id = openstack_networking_secgroup_v2.scoring_box_group.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = 51820
  port_range_max    = 58120
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh_tcp_control_room_2" {
  security_group_id =  openstack_networking_secgroup_v2.scoring_box_group.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = 22
  port_range_max    = 22
}

######Common #############

# ## default secgroup
# resource "openstack_networking_secgroup_v2" "default" {
#   name = "default"
# }