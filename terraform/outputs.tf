output "app_url" {
  description = "URL para acessar a aplicacao no navegador"
  value       = "http://${aws_instance.vm_app.public_ip}"
}
