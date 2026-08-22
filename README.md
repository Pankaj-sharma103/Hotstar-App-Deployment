Jenkins CI/CD Pipeline with Tomcat, SonarQube & Nexus
This repository contains the automation scripts, Ansible playbooks, and Jenkins Pipeline used to implement an end-to-end CI/CD pipeline for deploying a Java WAR application on Apache Tomcat.
The project automates the process from source-code checkout to application deployment, while integrating code quality analysis and artifact management.
🏗️ Architecture
Developer
    │
    ▼
  GitHub
    │
    ▼
 Jenkins
    │
    ├──────────────► SonarQube
    │                 Code Quality Analysis
    │
    ├──────────────► Maven
    │                 Build & Package
    │
    ├──────────────► Nexus
    │                 Artifact Repository
    │
    ▼
 Apache Tomcat
    │
    ▼
 Java WAR Application
📁 Repository Contents
File	Description
deploy.yml	Ansible playbook to copy the generated WAR file to the Tomcat webapps directory
jenkins.sh	Shell script to install and configure Jenkins
nexus.sh	Shell script to install and configure Nexus Repository
pipeline.groovy	Jenkins Pipeline script covering checkout, build, SonarQube analysis, artifact management, and deployment
sonarqube-setup.sh	Shell script to install and configure SonarQube
tomcat.sh	Shell script to install and configure Apache Tomcat
tomcat.yml	Ansible playbook to automate Tomcat installation and configuration

Technologies Used
AWS EC2 – Infrastructure
GitHub – Source Code Management
Jenkins – CI/CD Automation
Maven – Build & Packaging
SonarQube – Static Code Quality Analysis
Nexus Repository – Artifact Management
Apache Tomcat – Application Server
Ansible – Configuration Management & Deployment
Shell Scripting – Server Setup Automation
Java – Application Runtime

CI/CD Pipeline Flow

The Jenkins pipeline follows these stages:

1. Checkout

Jenkins pulls the latest application source code from GitHub.

GitHub → Jenkins
2. Build

Maven compiles the source code and packages the application as a WAR file.

Source Code → Maven → myapp.war
3. SonarQube Analysis

The application code is analyzed using SonarQube to identify code-quality issues and vulnerabilities.

Source Code → SonarQube → Quality Analysis
4. Quality Gate

The pipeline checks the SonarQube Quality Gate before continuing with the deployment process.

5. Artifact Management

The generated WAR file is uploaded to Nexus Repository for centralized artifact storage and version management.

myapp.war → Nexus Repository
6. Deployment

The WAR file is deployed to the Tomcat server using Ansible.

Jenkins → Ansible → Tomcat → webapps/
📜 Scripts & Playbooks
jenkins.sh

Automates the Jenkins server setup, including the required packages and Jenkins installation.

Purpose:

Install Java
Configure Jenkins repository
Install Jenkins
Enable Jenkins service
Start Jenkins
nexus.sh

Automates the installation and initial configuration of Nexus Repository.

Purpose:

Install required Java version
Download Nexus
Configure Nexus user
Set permissions
Start Nexus

Nexus is used as the centralized repository for storing application artifacts.

sonarqube-setup.sh

Automates the SonarQube server setup.

Purpose:

Install required Java version
Download SonarQube
Extract the SonarQube archive
Create a dedicated SonarQube user
Configure permissions
Start SonarQube
tomcat.sh

Shell script for setting up the Apache Tomcat application server.

Purpose:

Install Java
Download Tomcat
Extract Tomcat
Configure Tomcat
Set required permissions
Start Tomcat
tomcat.yml

Ansible playbook for automated Tomcat installation and configuration.

Purpose:

Install required packages
Download/install Tomcat
Configure Tomcat
Create/configure users
Start Tomcat service

Example execution:

ansible-playbook tomcat.yml
deploy.yml

Ansible deployment playbook used to copy the generated WAR file into Tomcat's webapps directory.

Example:

ansible-playbook deploy.yml

The deployment flow is:

Jenkins
   │
   ▼
Generated WAR
   │
   ▼
Ansible
   │
   ▼
Tomcat/webapps
pipeline.groovy

The Jenkins Pipeline script automates the complete CI/CD workflow.

Typical pipeline stages include:

Checkout
   ↓
Maven Build
   ↓
SonarQube Analysis
   ↓
Quality Gate
   ↓
Nexus Upload
   ↓
Ansible Deployment
   ↓
Tomcat

The pipeline provides a repeatable and automated deployment process instead of manually performing each step.

☁️ AWS Infrastructure

The project can be deployed using multiple EC2 instances:

EC2-1 → Jenkins
EC2-2 → SonarQube
EC2-3 → Nexus
EC2-4 → Tomcat

This separation allows each DevOps tool to run independently and makes the architecture easier to manage.

🔐 Required Configuration

Before running the pipeline, configure the following in Jenkins:

GitHub credentials/webhook
Maven
JDK
SonarQube server
SonarQube authentication token
Nexus credentials
SSH credentials for the Tomcat server
Ansible configuration/inventory

Also make sure the required AWS EC2 Security Group ports are configured appropriately.

Typical ports:

Service	Port
Jenkins	8080
Tomcat	8080
Nexus	8081
SonarQube	9000
SSH	22
▶️ How to Use
1. Clone the repository
git clone <repository-url>
cd <repository-directory>
2. Set up the servers

Run the required setup scripts on their respective EC2 instances:

./jenkins.sh
./nexus.sh
./sonarqube-setup.sh
./tomcat.sh

Make scripts executable if required:

chmod +x *.sh
3. Configure Tomcat with Ansible

Update the Ansible inventory with the Tomcat server details and run:

ansible-playbook tomcat.yml
4. Configure Deployment

Update the inventory and WAR-file path required by deploy.yml, then run:

ansible-playbook deploy.yml
5. Configure Jenkins Pipeline

Create a Jenkins Pipeline job and use the pipeline.groovy script.

Configure the required credentials and integrations for:

GitHub
SonarQube
Nexus
Tomcat/Ansible
6. Run the Pipeline

Once configured, Jenkins automatically performs:

Checkout
   ↓
Build
   ↓
Code Analysis
   ↓
Quality Gate
   ↓
Artifact Upload
   ↓
Deployment
🎯 Project Objective

The main objective of this project is to demonstrate a practical DevOps CI/CD implementation using industry-standard tools.

It reduces manual deployment work by automating:

Application builds
Code quality checks
Artifact management
Server configuration
Application deployment
📌 Key Learning Outcomes

Through this project, I gained hands-on experience with:

Jenkins CI/CD pipelines
GitHub integration
Maven build automation
SonarQube integration
Nexus artifact management
Apache Tomcat deployment
Ansible automation
Shell scripting
AWS EC2 infrastructure
End-to-end application deployment
