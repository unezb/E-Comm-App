resource "aws_instance" "jenkins" {
  ami                         = "ami-0fc5d935ebf8bc3bc"
  instance_type               = var.instance_type
  associate_public_ip_address = true

	subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  key_name = "test_key"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io git

              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "${var.name_prefix}-jenkins-server"
  }
}