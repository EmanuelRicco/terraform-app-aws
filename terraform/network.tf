resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_app" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw_app" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_route_table" "route_table_app" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_app.id
  }

  tags = {
    Name = "rt-app-public"
  }
}

resource "aws_route_table_association" "route_table_assoc_app" {
  subnet_id      = aws_subnet.subnet_app.id
  route_table_id = aws_route_table.route_table_app.id
}

resource "aws_security_group" "sg_app" {
  name        = "sgapp"
  description = "Security group para a aplicacao"
  vpc_id      = aws_vpc.app_vpc.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_app.id
  description       = "Acesso SSH"
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_app.id
  description       = "Acesso HTTP"
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_app.id
  description       = "Acesso HTTPS"
}

resource "aws_security_group_rule" "app_port" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_app.id
  description       = "Acesso a API na porta 8000"
}

resource "aws_security_group_rule" "regra_de_saida" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_app.id
}
