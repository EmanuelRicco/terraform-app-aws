output "public_ip_address" {
  description = "O endereço IP público da aplicação"
  value       = mgc_network_public_ips.public_ip_app.public_ip
}


output "vpc_id" {
  description = "O ID da VPC criada"
  value       = mgc_network_vpcs.vpc_app.id
}


output "subnet_id" {
  description = "O ID da Subnet criada"
  value       = mgc_network_vpcs_subnets.subnet_app.id
}

output "security_group_id" {
  description = "O ID do Security Group da aplicação"
  value       = mgc_network_security_groups.sg_app.id
}
