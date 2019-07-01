$script = <<-SCRIPT
#!/bin/sh

# the terraform version to be installed
TF_ENV="0.11.14"

# install latest updates
yum update -y

# install git
yum install -y git

# install jenkins
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y java-1.8.0-openjdk-devel jenkins
systemctl start jenkins
systemctl status jenkins

# install terraform
yum install -y zip unzip
curl -O https://releases.hashicorp.com/terraform/${TF_ENV}/terraform_${TF_ENV}_linux_amd64.zip
unzip terraform_${TF_ENV}_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_${TF_ENV}_linux_amd64.zip
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: $script
  config.vm.network "forwarded_port", guest: 8080, host: 8080
end