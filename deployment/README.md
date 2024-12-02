# Deployment

These scripts are used to build the Docker image, push it to ECR2 (build-and-upload), pull it from ECR2, and run it (pull-and-run).

## How to run these scripts:

To build and upload the image:

```bash
./build-and-upload.sh api (or client)
```

To pull and run the image:

```bash
./pull-and-upload.sh api (or client) port_number
```

Examples:

```bash
./build-and-upload.sh api
```
```bash
./pull-and-upload.sh api 8080
```

### Disclaimer: 

You must define an AWS profile beforehand. These scripts use the xl-devps profile by default.
