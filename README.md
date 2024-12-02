# Devops Playground

This is just a POC to use Terraform to deploy some infrastructure in AWS.  
For the POC, an API and a web application were used, obtained from here: [React Exress App Medium Tutorial](https://github.com/Joao-Henrique/React_Express_App_Medium_Tutorial).
Additionally, this repository is based on an Xmartlabs template.


This repository contains four distinct sections:

* [Api](./api): everything related to API (node api).
* [Client](./client): everything related to the website (react website).
* [Infrastructure](./infrastructure): everything related to infrastructure deployment using Terraform.
* [Deployment](./deployment): everything related to day-to-day deployment of an application to the cloud.

Every directory contains specific documentation, so be sure to check them out.

## Docker Compose

The Docker Compose file replicates the same infrastructure defined in the Terraform folder. 
The purpose of this is to provide an alternative implementation, in this case, hosting everything on the same machine using Docker containers.
