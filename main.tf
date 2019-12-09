provider "aws" {
    region = "eu-central-1"
}

resource "aws_security_group" "nodejs_jenkins_app" {
name = "nodejs_jenkins_app"
description = "Open ports 80 443 3000 22"

ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  
ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]

}


}

resource "aws_instance" "node_app" {
    
    ami = "ami-0cc0a36f626a4fdf5"
    count = 1
    vpc_security_group_ids = [aws_security_group.web_server.id]
    
    instance_type = "t2.micro"
    key_name = "key"
    user_data = <<EOF
#!/bin/bash
apt update -y
apt -y install nodejs
apt -y install nodejs
EOF
    tags = {
        Name = "node_app"
        Group = "test"

    }
  
}



