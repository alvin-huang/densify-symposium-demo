provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-densify-demo"
    key    = "demo.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  count         = 2

  tags {
    Name      = "instance-${terraform.workspace}-${count.index}"
    Terraform = "true"
  }
}
