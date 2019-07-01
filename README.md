## Create a Vagrant Jenkins instance with a Terraform Pipeline ##

This is a lab to demonstrate running Jenkins on a Vagrant VM and create a Jenkins pipeline which will use terraform to create a security group in AWS

### Setup ###

* Vagrant version 2.2.4
* Virtualbox version 6.0.8
* Jenkins version 2.176.1

Use the Vagrantfile to create and install required components (using Virtualbox):
```
vagrant up
```
Retrieve the Jenkins initial admin password:
```
vagrant ssh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

The Jenkins URL is http://127.0.0.1:8080

After initializing Jenkins; install the recommended plugins and the **CloudBees AWS Credentials Plugin** https://plugins.jenkins.io/cloudbees-credentials

Install the Blue Ocean plugin (optional) https://plugins.jenkins.io/blueocean

### AWS Credentials ###

You will need IAM user credentials with permissions to create an ec2 Security Group.

Within Jenkins Credentials; add a Global Credential of type **AWS Credential**

* Set **ID** to `aws-creds`		This is used in the pipeline Credentials Binding `credentialsId`
* Add your ACCESS_KEY_ID	This is used in the pipeline Credentials Binding `accessKeyVariable`
* Add your SECRET_ACCESS_KEY	This is used in the pipeline Credentials Binding `secretKeyVariable`

### Pipeline ###

Create a pipeline job, then within the **Pipeline** configuration set the definition to **Pipeline script from SCM**. Add `https://github.com/david-wells-1/jenkins-vagrant-terraform-pipeline.git`, the `Script Path` will automatically be set to the Jenkinsfile.

In this example, the Jenkinsfile pipeline will create a security group in the default VPC in eu-west-2
