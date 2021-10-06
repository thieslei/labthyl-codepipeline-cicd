# python_labs_scripts

<BR>

## 📝 Table of Contents

- [What does this project](#aboutit)
- [How does it works](#Howdoesitworks)
- [Setup](#setup)
- [Built Using](#built_using)
- [Authors](#authors)
<!-- - [References](#references) -->

<BR>

## 💪🏽️ What this project is about?? <a name = "aboutit"></a>
This project controls all my pipelines running on AWS CodePipeline, using GitHubActions, Terraform, AWS CodePipeline and AWS Code Commit.

![Alt text](img/codepipeline.png?raw=true "codepipeline")

<BR>

## 🛠️ How does it works?? <a name = "Howdoesitworks"></a>
It's a project that orchestrated by GitHubActions that creates my pipelines on AWS CodePipeline to run my terraform codes on AWS.

You will need:
* AWS Account
* AWS Credentials
* DockerHub Credentials
* GitHub Profile

To execute this projecto you just need:

* Run a PR from any branch to "main"

It will start GitHubActions pipeline and execute your code.

<BR>

## ⚙️ Setup <a name = "setup"></a>
To use this code you have to setup some resources as mentioned below.
* AWS accesskey and secretkey on repo secret(needed to deploy your resources on AWS Cloud).
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
* DockerHub Credentials on SecretManager (needed to pull and push containers from Docker Hub).
* CodeAppConnect to GitHub on AWS Pipelines (used to connect and download your codes).

<BR>

## ⛏️ Built Using <a name = "built_using"></a>
- [AWS Account](https://amazon.com/aws) - AWS Account
- [DockerHub](https://hub.docker.com/) - DockerHub
- [GitHub](https://github.com) - GitHub
- [GitHub Actions](https://github.com/features/actions) - GitHub Actions
- [Terraform](https://www.terraform.io/) - Terraform

<BR>
<!--
## 📕️ References <a name = "references"></a>
* 

<BR>
-->

## ✏️ Authors <a name = "authors"></a>

- 📩️ - thieslei@gmail.com
- Thieslei's [GitHub Profile](https://github.com/thieslei)

