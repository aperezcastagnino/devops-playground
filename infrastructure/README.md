# Terraform Basic Infra

Developed by [Xmartlabs](https://xmartlabs.com/).

## Overview

This repository contains Terraform code designed to deploy a set of infrastructure resources on AWS using modules. By combining these modules, you will be able to deploy solutions ranging from simple setups with a single EC2 instance to complex multi-service solutions utilizing ECS clusters. Some of the resources included in the repository are:

- Elastic Compute Cloud (EC2)
- Elastic Container Service (ECS)
- Relational Database Service (RDS)

## Directory Structure

- `main.tf`: The main Terraform configuration file containing module definitions.
- `variables.tf`: Define input variables for the Terraform modules.
- `outputs.tf`: Define output values to be displayed after the Terraform execution.
- `provider.tf`: Configure AWS provider settings.
- `environments/`: Folder that contains the different environment configurations
  - `test/`: Test environment configuration files.
    - `terraform.tfvars`: Variables for the example environment.
- `modules/`
  - `ec2/`: EC2 instance.
  - `ec2-iam-profile/`: EC2 Iam profile module. 
  - `ecr/`: Elastic Container Registry module.
  - `rds/`: RDS module. 
  - `vpc/`: VPC module.
	
## Get Started

### Prerequisites

Before you begin, ensure you have the following prerequisites:

- **AWS Account:** You must have an AWS account and necessary credentials to deploy resources.
- **Terraform:** Ensure Terraform is installed on your local machine. You can download it from [terraform.io](https://www.terraform.io/downloads.html).
- **AWS Client:** Install in your machine the [aws client tool](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) corresponding to your operating system.
- **Terraform docs**: Required for updating the modules documentation if you modify them. You can install the tool from [terraform-docs.io](https://terraform-docs.io/).

### Configure AWS Client in your machine

Before utilizing the template, you need to configure the AWS client on your machine. Here are some recommendations we suggest for doing so:

- Avoid using your user account to execute the Terraform commands. Instead, create an independent user with only the necessary permissions and configure the AWS client with it.

- Refrain from using the default configuration in the client. It's preferable to create a profile specifically for the project.

### Create s3 bucket for backend

In this implementation, we're going to use an s3 bucket as backend for our infrastructure as code.

After validate that you meet all prerequisites. Go to AWS and create an S3 bucket with server-side encryption enabled. (This resource has to be created manually).

We recommend using as bucket name {account-id}-tfstate. As the S3 bucket name has to be globally unique, this name is rarely occupied as contents of your account id and makes it intuitive that there is where tfstate is allocated.

### Providers file

After creating the bucket, you need to configure the backend in the `provider.tf` file. To do that, we have a backend-config file (is provided in the file `config/backend-config.properties`) with the following information:

**bucket=** Place your S3 bucket name here.

**key=** Specify the name of the tfstate file.

**region=** Indicate the region where we are going to work. You have to input the value directly since the "provider" block doesn't allow variables.

Once the file is created, initialize the project using it:

```bash
terraform init -backend-config=<config-path>
```

### Workspaces

In order to separate environments, we're going to use **workspaces**. We're going to select the workspace of the environment where we are going to work or create a new one.

To list the existing workspace you can use:
```bash
terraform workspace list
```
To select the workspace:
```bash
terraform workspace select {workspace-name}
```
To create a new workspace:
```bash
terraform workspace new {workspace-name}
```

### Usage

In order to separate the variables of the different environments, we are going to have a different **{environment}.tfvars** file for each one.

```bash
# Validates the syntax
terraform validate
# Evaluates the code with the state to know what is going to be modified
terraform plan -var-file="./environments/{environment}.tfvars"
# Apply the changes
terraform apply -var-file="./environments/{environment}.tfvars"
## You will be prompted to confirm the resource creation. Enter `yes` to proceed.
# Destroy everything
terraform destroy -var-file="./environments/{environment}.tfvars"
```

```bash
terraform fmt
```
