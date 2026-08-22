#install git to pull the code java to run jenknis and maven to build the code
yum install git java-21-amazon-corretto maven -y

#By default, Jenkins is not available in the standard RHEL/CentOS/Amazon Linux repositories
#plus jenkins repo to your system so you can install the jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/rpm-stable/jenkins.repo

#after adding jenknis repo we also need to import jenknis GPG key
#verify that the Jenkins package is authentic and has not been tampered with.
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2023.key

yum install jenkins -y
systemctl start jenkins
systemctl status jenkins

#auto-start jenkins
chkconfig jenkins on

