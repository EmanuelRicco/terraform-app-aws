variable "api_key" {
  sensitive = true
}
variable "region" {
  description = "Região usada para criar os recursos na magalu"
  type        = string
  default     = "br-se1"
}