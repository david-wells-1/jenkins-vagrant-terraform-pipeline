variable "region" {
  default = "eu-west-2"
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "jenkins-pipeline" {
  name        = "jenkins-vagrant-terraform-pipeline"
  description = "created-using-jenkins-vagrant-terraform-pipeline"

  tags = {
    Name = "jenkins-vagrant-terraform-pipeline"
  }
}
