# Jenkins CI/CD Pipeline with Tomcat, SonarQube & Nexus

This repo holds the scripts, Ansible playbooks, and Jenkins pipeline I used to build an end-to-end CI/CD setup for deploying a Java WAR application on Apache Tomcat.

The idea is to automate everything from pulling the source code to getting it live on the server, while also running code quality checks and keeping build artifacts organized along the way.

## Architecture

```
Developer
   │
   ▼
 GitHub
   │
   ▼
Jenkins ──────► SonarQube (code quality analysis)
   │
   ├──────────► Maven (build & package)
   │
   ├──────────► Nexus (artifact repository)
   │
   ▼
Apache Tomcat
   │
   ▼
Java WAR Application
```

## What's in this repo

| File | What it does |
|---|---|
| `jenkins.sh` | Installs and configures Jenkins |
| `nexus.sh` | Installs and configures Nexus Repository |
| `sonarqube-setup.sh` | Installs and configures SonarQube |
| `tomcat.sh` | Installs and configures Apache Tomcat |
| `tomcat.yml` | Ansible playbook to automate Tomcat setup |
| `deploy.yml` | Ansible playbook that copies the built WAR file into Tomcat's `webapps` directory |
| `pipeline.groovy` | The Jenkins pipeline script — checkout, build, SonarQube analysis, artifact upload, and deployment |

## Tech stack

- **AWS EC2** – infrastructure
- **GitHub** – source control
- **Jenkins** – CI/CD orchestration
- **Maven** – build & packaging
- **SonarQube** – static code analysis
- **Nexus Repository** – artifact storage
- **Apache Tomcat** – application server
- **Ansible** – configuration & deployment automation
- **Shell scripting** – server setup
- **Java** – application runtime

## How the pipeline works

1. **Checkout** — Jenkins pulls the latest code from GitHub.
2. **Build** — Maven compiles the code and packages it into a WAR file.
3. **SonarQube analysis** — the code gets scanned for quality issues and vulnerabilities.
4. **Quality gate** — the pipeline won't move forward unless the code passes SonarQube's quality gate.
5. **Artifact upload** — the WAR file gets pushed to Nexus for version-controlled storage.
6. **Deployment** — Ansible takes the WAR file from Nexus and drops it into Tomcat's `webapps` folder.

## What each script actually does

**`jenkins.sh`**
Installs Java, sets up the Jenkins repo, installs Jenkins itself, and starts the service.

**`nexus.sh`**
Installs the right Java version, downloads Nexus, sets up a dedicated user with proper permissions, and starts it up. Nexus ends up being the central place all built artifacts live.

**`sonarqube-setup.sh`**
Installs Java, downloads and extracts SonarQube, creates a dedicated user, sets permissions, and starts the service.

**`tomcat.sh`**
Installs Java, downloads and extracts Tomcat, handles configuration and permissions, and starts it.

**`tomcat.yml`**
Same idea as `tomcat.sh` but done through Ansible instead of a shell script — installs packages, sets up Tomcat, configures users, and starts the service. Run it with:

```bash
ansible-playbook tomcat.yml
```

**`deploy.yml`**
Handles the actual deployment: takes the WAR file Jenkins built and copies it into Tomcat's `webapps` directory.

```bash
ansible-playbook deploy.yml
```

Flow: `Jenkins → WAR file → Ansible → Tomcat/webapps`

**`pipeline.groovy`**
Ties the whole thing together as a Jenkins pipeline:

```
Checkout → Maven Build → SonarQube Analysis → Quality Gate → Nexus Upload → Ansible Deploy → Tomcat
```

Instead of running each of these steps by hand, Jenkins runs them automatically every time.

## AWS setup

I split this across four EC2 instances so each tool runs independently:

| Instance | Role |
|---|---|
| EC2-1 | Jenkins |
| EC2-2 | SonarQube |
| EC2-3 | Nexus |
| EC2-4 | Tomcat |

Keeping them separate makes the whole thing a lot easier to manage and troubleshoot.

## Before you run anything

Make sure the following are configured in Jenkins:

- GitHub credentials / webhook
- Maven and JDK installations
- SonarQube server + auth token
- Nexus credentials
- SSH credentials for the Tomcat server
- Ansible inventory/configuration

Also double check your EC2 security group rules allow the ports below:

| Service | Port |
|---|---|
| Jenkins | 8080 |
| Tomcat | 8080 |
| Nexus | 8081 |
| SonarQube | 9000 |
| SSH | 22 |

## Getting started

**1. Clone the repo**
```bash
git clone <repository-url>
cd <repository-directory>
```

**2. Set up the servers**

Run each setup script on its respective EC2 instance:

```bash
chmod +x *.sh
./jenkins.sh
./nexus.sh
./sonarqube-setup.sh
./tomcat.sh
```

**3. Configure Tomcat with Ansible**

Update the inventory file with your Tomcat server details, then run:

```bash
ansible-playbook tomcat.yml
```

**4. Set up deployment**

Update the inventory and WAR file path in `deploy.yml`, then run:

```bash
ansible-playbook deploy.yml
```

**5. Configure the Jenkins pipeline**

Create a new Jenkins pipeline job using `pipeline.groovy`, and connect it to GitHub, SonarQube, Nexus, and Tomcat/Ansible.

**6. Run it**

Once everything's wired up, Jenkins takes care of the rest — checkout, build, analysis, quality gate, artifact upload, and deployment, all in one go.

## Why I built this

I wanted to get real, hands-on experience with a full DevOps pipeline rather than just reading about one — automating the build, quality checks, artifact management, and deployment instead of doing any of it manually.

## What I learned

- Setting up and running Jenkins CI/CD pipelines
- Integrating GitHub into an automated workflow
- Build automation with Maven
- Wiring SonarQube into a pipeline for code quality gates
- Managing artifacts with Nexus
- Deploying to Apache Tomcat
- Writing and running Ansible playbooks
- Shell scripting for server setup
- Working with AWS EC2 infrastructure
- Putting together a full end-to-end deployment process
