data "openstack_images_image_v2" "boot_image" {
  name         = "UbuntuJammy2204_new" // Replace with your desired image name
  most_recent  = true
}
