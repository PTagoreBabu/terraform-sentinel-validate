provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "server" {

    ami = var.ami
    instance_type = var.type
    associate_public_ip_address = true

    user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update -u
      sudo apt install -y nginx
      sudo systemctl start nginx
      sudo echo "<html><body><h1>Hello this is a cloud server at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF

#tags = {
#  Name = "sentinal-vcs-server1"
#}
}

variable "ami" {
type = string
default = "ami-0a3c8f9955a39dafb"
}

variable "type" {
type = string
default = "t2.medium"
}
