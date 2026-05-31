resource "aws_key_pair" "app_key" {
  key_name   = "app-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "vm_app" {
  ami           = "ami-0533a139e02b00be4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app_key.key_name

  subnet_id              = aws_subnet.subnet_app.id
  vpc_security_group_ids = [aws_security_group.sg_app.id]


  user_data = base64encode(templatefile("${path.module}/script/docker_install.sh", {
    app_py       = file("${path.module}/../app/app.py")
    dockerfile   = file("${path.module}/../app/Dockerfile")
    requirements = file("${path.module}/../app/requirements.txt")
  }))

}
