resource "mgc_network_vpcs" "vpc_app" {
  name        = "vpc-app"
  description = "VPC para aplicacao"
}

resource "mgc_network_subnetpools" "subnetpool_app" {
  name        = "subnetpool-app"
  description = "Subnet Pool para aplicacao"
  cidr        = "172.26.0.0/16"
}

resource "mgc_network_vpcs_subnets" "subnet_app" {
  cidr_block      = "172.26.1.0/24"
  description     = "Subnet para aplicacao"
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
  ip_version      = "IPv4"
  name            = "subnet-app"
  subnetpool_id   = mgc_network_subnetpools.subnetpool_app.id
  vpc_id          = mgc_network_vpcs.vpc_app.id
}

resource "mgc_network_vpcs_interfaces" "interface_app" {
  name   = "interface-app"
  vpc_id = mgc_network_vpcs.vpc_app.id

  depends_on = [mgc_network_vpcs_subnets.subnet_app]
}

resource "mgc_network_security_groups" "sg_app" {
  name                  = "sg-app"
  description           = "Security Group para aplicacao"
  disable_default_rules = false
}

resource "mgc_network_security_groups_rules" "entrada_http" {
  description       = "Entrada HTTP para aplicacao"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.sg_app.id
}


resource "mgc_network_security_groups_rules" "entrada_https" {
  description       = "Entrada HTTPS para aplicacao"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.sg_app.id
}

resource "mgc_network_security_groups_rules" "entrada_ssh" {
  description       = "Entrada SSH para aplicacao"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.sg_app.id
}

resource "mgc_network_security_groups_rules" "acesso_app" {
  description       = "Acesso a aplicacao na porta 8000"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 8000
  port_range_max    = 8000
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.sg_app.id
}

resource "mgc_network_security_groups_attach" "attach_sg_app" {
  security_group_id = mgc_network_security_groups.sg_app.id
  interface_id      = mgc_network_vpcs_interfaces.interface_app.id
}

resource "mgc_network_public_ips" "public_ip_app" {
  description = "Public IP para aplicacao"
  vpc_id      = mgc_network_vpcs.vpc_app.id
}

resource "mgc_network_public_ips_attach" "app_ip_attachment" {
  public_ip_id = mgc_network_public_ips.public_ip_app.id
  interface_id = mgc_network_vpcs_interfaces.interface_app.id
}
