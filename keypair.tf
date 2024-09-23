resource "openstack_compute_keypair_v2" "djchicken" {
  name       = "djchicken"
  public_key = file("djchicken.pub")
}
