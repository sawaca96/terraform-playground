provider "aws" {
  region  = "ap-northeast-2"
  profile = "terraform-up"
}

resource "aws_instance" "JMusicBot" {
  ami                    = "ami-0ba5cd124d7a79612"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public.id]
  user_data              = <<-EOF
	#!/bin/bash
  sudo apt-get -y update
  sudo apt-get -y install openjdk-8-jdk
  wget https://github.com/jagrosh/MusicBot/releases/download/0.3.6/JMusicBot-0.3.6.jar
  { echo "${var.token}"; echo "${var.owner}"; } | java -Dnogui=true -jar JMusicBot-0.3.6.jar
	EOF
  tags = {
    Name = "JMusicBot"
  }
}

resource "aws_security_group" "public" {
  name = "public"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
