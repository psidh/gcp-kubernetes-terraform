# GCP-Kubernetes-Engine w/ Terraform

This repository contains the Terraform code to create a Kubernetes Engine cluster on Google Cloud Platform.

It also contains the Kubernetes manifests to deploy a sample Node.js application. 

A Dockerfile is also included to build the Docker image. 

A `service.yaml` file is included to expose the application to the internet. 

`main.tf` file contains the Terraform code to create the Kubernetes Engine cluster. 

`variables.tf` file contains the variables used in the `main.tf` file.


## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Google Cloud Platform](https://console.cloud.google.com/)
- [Kubernetes Engine Cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)
- [Node.js](https://nodejs.org/en/download/)
- [Docker](https://docs.docker.com/get-docker/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/) - Optional

## Setup

1. Clone the repository:

```bash
git clone https://github.com/psidh/terraform-gcp-kubernetes-engine.git
```

2. Change into the directory:

```bash
cd terraform-gcp-kubernetes-engine
```

3. Initialize the Terraform:

```bash
terraform init
```

4. Create a new file `terraform.tfvars` and add the following variables:

```hcl
project_id = "your-project-id"
region     = "us-central1"
zone       = "us-central1-a"
cluster_name = "your-cluster-name"
```

5. Apply the Terraform:

```bash
terraform apply
```
