variable "openstack_application_credential_secret" {
    description = "OpenStack token"
    type = string
}

variable "openstack_application_credential_name" {
    description = "OpenStack application credential name"
    type = string
}

variable "openstack_auth_url" {
    description = "OpenStack auth url"
    type = string
    # for some reason if you don't add /v3 it uses port 443...
    # this took at least an hour to figure out
    default = "https://stack.ritsec.cloud:5000/v3"
}

variable "openstack_project_id" {
    description = "OpenStack project ID"
    type = string
    default = "208593929a8948ee9433d1a5e4dd07c6"
}

variable "openstack_user_domain_name" {
    description = "OpenStack domain name"
    type = string
    default = "Default"
}

variable "openstack_region_name" {
    description = "OpenStack region name"
    type = string
    default = "phoenix"
}

variable "openstack_project_domain_id" {
    description = "OpenStack project domain ID"
    type = string
    default = "default"
}

variable "openstack_username" {
    description = "OpenStack application credential name"
    type = string
}