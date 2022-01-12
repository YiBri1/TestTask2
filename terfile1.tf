provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "test_webserver" {
  ami = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.hehe.id]
  user_data = file("my_data.sh")
}

resource "aws_security_group" "hehe" {
  name        = "hehe"

  dynamic "ingress" {

    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}



resource "aws_eip" "eip" {
  instance = aws_instance.test_webserver.id
  vpc      = true
}


//////////////////////////DNS_stuff



resource "aws_route53_zone" "yibri" {
  name = "yibri.xyz"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.yibri.zone_id
  name    = "www.yibri.xyz"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.eip.public_ip]
}



output "name_server"{
  value=aws_route53_zone.yibri.name_servers
}
