output "conexao_ssh" {
  description = "Comando para acessar a instancia via SSH"
  value       = "ssh -i ~/.ssh/id_ed25519 ubuntu@${aws_instance.vm_app.public_ip}"
}

output "app_url" {
  description = "URL para acessar a aplicacao no navegador"
  value       = "http://${aws_instance.vm_app.public_ip}"
}
