resource "aws_instance" "app_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.instance.id] 
  user_data                   = <<EOF
    #!/bin/bash
    db_address="${data.terraform_remote_state.db.outputs.db_address}"
    db_port="${data.terraform_remote_state.db.outputs.db_port}"
    echo "Hello, World. DB is at $db_address:$db_port" >> index.html
    nohup busybox httpd -f -p "${var.server_port}" &
    EOF
}

data "terraform_remote_state" "db" {
  backend = "local"

  config = {
    path = "../team1/terraform.tfstate"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance-${random_integer.int.result}"
  vpc_id = "vpc-008e2879"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}