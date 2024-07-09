# canso-data-plane-k8s-cluster-tf
Terraform Scripts/Modules to set up Canso-compatible Kubernetes Clusters.

## Overview
This repository contains the necessary Terraform modules to set up a Canso-compatible data plane cluster on Kubernetes. The main components included are as follows -


- **EFS**: Module for [AWS Elastic File Storage](https://aws.amazon.com/efs/). Among other things, used to store Airflow DAG files. 
- **RDS**: Module for [AWS Relational Database Service](https://aws.amazon.com/rds/). Among other things, used as an production grade DB for Airflow.
- **ALB Controller**: Module for the [AWS ALB Controller](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html).
- **EKS**: Module to provision an [AWS EKS](https://docs.aws.amazon.com/eks/latest/userguide/clusters.html) cluster.
- **IRSA Roles**: Modules for [AWS IAM roles for Service Accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).
- **Public ALB**: Module to create an [Public ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html). This is used to communicate with the Canso Control Plane. In future releases, this will be replaced with a more robust approach.
- **VPC**: Module to provision an [AWS VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) & [Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html#subnet-basics) for the data plane.

Configs/input variables are stored in `.tfvars` and `.conf` files. 

## Modules

The following terraform modules are used to set up the data plane cluster -

- `canso-vpc`
- `canso-eks`
- `canso-irsa`
- `canso-efs`
- `canso-rds`
- `canso-alb-controller`
- `canso-public-alb`


## Dependencies

- **Remote Backend** - The remote backend used by default is S3. `.tfstate` files are stored in an S3 bucket as well. To understand more about backends in Terraform, see [the official Terraform backend settings documentation](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- **Terraform Lock** - We use an DynamoDB table by default to apply locks while doing a TF plan/apply. This ensures that others cannot acquire the lock and potentially corrupt your state. For creating a [DynamoDB table](https://aws.amazon.com/dynamodb/)

These details are stored in a `.conf` file and used while running `terraform apply`. A sample configuration is shown below

```conf
encrypt        = true
bucket         = "canso-terraform-s3"
dynamodb_table = "canso-terraform-lock-dynamodb"
key            = "path/to/mystatefile.tfstate"
region         = "ap-south-1"
profile        = "default"
```

## Directory Structure

Each module is contained within its respective directory and is called from a separate folder that includes the following files:

- `main.tf`: Main configuration file.
- `data-source.tf`: Data source configuration.
- `outputs.tf`: Output values.
- `providers.tf`: Providers configuration.
- `remote-state.tf`: Remote state configuration.
- `variables.tf`: variables definition.

Here's a quick summary of how the directory looks like -

```markdown

canso-data-plane-k8s-cluster-tf/
├── LICENSE                             <- Open-source license if one is chosen
├── README.md                           <- The top-level README for developers using this project.
│
├── canso-dataplane-configs/            <- Terraform configs for each component
│   ├── efs/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   ├── rds/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   ├── alb-controller/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   ├── eks/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   ├── irsa-roles/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   ├── public-alb/
│   │   ├── auto.tfvars
│   │   └── backend.conf
│   └── vpc/
│       ├── auto.tfvars
│       └── backend.conf
│
└── modules/                             <- Directory to contain all Terraform modules
    ├── canso-vpc/                       <- VPC configuration module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    ├── canso-eks/                       <- EKS cluster configuration module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    ├── canso-irsa/                      <- IRSA roles configuration module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    ├── canso-efs/                       <- EFS configuration for Airflow module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    ├── canso-rds/                       <- RDS configuration for Airflow module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    ├── canso-alb-controller/            <- ALB controller configuration module
    │   ├── main.tf
    │   ├── data-source.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── remote-state.tf
    │   └── variables.tf
    │
    └── canso-public-alb/                <- Public ALB configuration module
        ├── main.tf
        ├── data-source.tf
        ├── outputs.tf
        ├── providers.tf
        ├── remote-state.tf
        └── variables.tf
```

### Usage

### Step 1 - AWS VPC

1. Update the S3 bucket and DynamoDB table details in [`backend.conf`](./canso-dataplane-configs/vpc/backend.conf) if needed.
2. Update the [`auto.tfvars`](./canso-dataplane-configs/vpc/auto.tfvars) file if needed.

To create the VPC, navigate to the `canso-vpc` module directory and run the following Terraform commands:

```console
cd modules/canso-vpc
terraform init -backend-config=../../canso-dataplane-configs/vpc/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/vpc/auto.tfvars
```

---

### Step 2 - AWS EKS

1. Update the S3 bucket and DynamoDB table details in [`backend.conf`](./canso-dataplane-configs/eks/backend.conf) if needed.
2. Update the [`auto.tfvars`](./canso-dataplane-configs/eks/auto.tfvars) file if needed. Use private `subnet_ids` and `vpc_id` from the outputs of the VPC module.

To create the EKS, navigate to the `canso-eks` module directory and run the following Terraform commands:

```console
cd modules/canso-eks
terraform init -backend-config=../../canso-dataplane-configs/eks/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/eks/auto.tfvars
```

> [!IMPORTANT]
> Dependencies (Output from the VPC module to be used as inputs here)
> 1. `vpc_module_private_subnet_ids`: The private subnet IDs of the VPC
> 2. `vpc_module_vpc_id`: The ID of the VPC

```terraform
private_subnet_ids = [
  "subnet-xxxxxxxxxxxxxxxxx",
  "subnet-xxxxxxxxxxxxxxxxx",
]
public_subnet_ids = [
  "subnet-xxxxxxxxxxxxxxxxx",
  "subnet-xxxxxxxxxxxxxxxxx",
]
vpc_id = "vpc-xxxxxxxxxxxxxxxxx"
```

---

### Step 3 - AWS IRSA Roles

We create the following IRSA roles in this step, each of which are in separate modules.



| IRSA Component   | Path to TfVars File                                                              | Path to conf file                                                              | RoleArnName            |
|------------------|----------------------------------------------------------------------------------|--------------------------------------------------------------------------------|------------------------|
| ALB Controller   | [Tfvars File](./canso-dataplane-configs/irsa-roles/alb-controller/auto.tfvars)   | [Conf File](./canso-dataplane-configs/irsa-roles/alb-controller/backend.conf)  | canso-dataplane-alb-controller-irsa-role        |
| Karpenter        | [Tfvars File](./canso-dataplane-configs/irsa-roles/karpenter/auto.tfvars)        | [Conf File](./canso-dataplane-configs/irsa-roles/karpenter/backend.conf)       | canso-dataplane-karpenter-prod-irsa-role         |
| External Secrets | [Tfvars File](./canso-dataplane-configs/irsa-roles/external-secrets/auto.tfvars) | [Conf File](./canso-dataplane-configs/irsa-roles/external-secrets/backend.conf)| canso-dataplane-external-secrets-prod-irsa-role  |
| EBS Driver       | [Tfvars File](./canso-dataplane-configs/irsa-roles/ebs-driver/auto.tfvars)       | [Conf File](./canso-dataplane-configs/irsa-roles/ebs-driver/backend.conf)      | canso-dataplane-ebs-csi-prod-irsa-role           |
| EFS Driver       | [Tfvars File](./canso-dataplane-configs/irsa-roles/efs-driver/auto.tfvars)       | [Conf File](./canso-dataplane-configs/irsa-roles/efs-driver/backend.conf)      | canso-dataplane-efs-csi-prod-irsa-role           |
| Spark IRSA       | [Tfvars File](./canso-dataplane-configs/irsa-roles/spark/auto.tfvars)            | [Conf File](./canso-dataplane-configs/irsa-roles/spark/backend.conf)           | canso-dataplane-spark-s3-irsa-role               |
| Canso Agent IRSA | [Tfvars File](./canso-dataplane-configs/irsa-roles/canso-agent/auto.tfvars)      | [Conf File](./canso-dataplane-configs/irsa-roles/canso-agent/backend.conf)     | devagent-dataplane-irsa-role                     |
| Airflow IRSA     | [Tfvars File](./canso-dataplane-configs/irsa-roles/airflow/auto.tfvars)          | [Conf File](./canso-dataplane-configs/irsa-roles/airflow/backend.conf)         | airflow-canso-dataplane-irsa-role                |


> **NOTE**
>
>The RoleArnName values listed in the table above are the default role names created when using the Terraform module. These default names are compatible with the canso-helm-chart without requiring any modifications.
>
>If you want to use different role names, you can modify the `RoleArnName` in the respective tfvars files. However, please note that any changes to these names must be reflected when using the canso-helm-chart to deploy the Canso Dataplane. Ensure that the role names in your Helm chart configuration match the ones you've defined in your Terraform configuration to maintain consistency and proper functionality.

1. Update the S3 bucket and DynamoDB table details in the `backend.conf` file in the respective folders if needed.
2. Update the `auto.tfvars` file in the respective folder if needed

To create the IRSA Roles, navigate to the `canso-irsa` module directory and run the following Terraform commands:

1. Create ALB controller IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/alb-controller/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/alb-controller/auto.tfvars
```

2. Create Karpenter IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/karpenter/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/karpenter/auto.tfvars
```

3. Create external-secrets IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/external-secrets/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/external-secrets/auto.tfvars
```

4. Create ebs-driver IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/ebs-driver/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/ebs-driver/auto.tfvars
```

5. Create efs-driver IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/efs-driver/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/efs-driver/auto.tfvars
```

6. Create Spark IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/spark/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/spark/auto.tfvars
```

7. Create Canso Agent IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/dev-agent/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/dev-agent/auto.tfvars
```

8. Create Airflow IRSA

```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/airflow/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/airflow/auto.tfvars
```

---

### Step 4 - AWS EFS

> [!IMPORTANT]
> Dependencies (Output from the VPC module to be used as inputs here)
> 1. `subnet_ids`: The private subnet IDs of the VPC
> 2. `vpc_name`: The name of the VPC

1. Update the S3 bucket and DynamoDB table details in [`backend.conf`](./canso-dataplane-configs/efs/backend.conf) if needed.
2. Update the [`auto.tfvars`](./canso-dataplane-configs/efs/auto.tfvars) file if needed. Use private `subnet_ids` and `vpc_name` from the outputs of the VPC module.

To create the EFS, navigate to the `canso-efs` module directory and run the following Terraform commands:

```console
cd modules/canso-efs
terraform init -backend-config=../../canso-dataplane-configs/efs/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/efs/auto.tfvars
```

### Step 5 - AWS RDS

> [!CAUTION]
> The RDS module is used to create a production grade DB for Airflow. When deployed using helm
> Airflow creates a development Postgres DB, which is fine for development and testing purposes.
> However, for production pipelines & jobs orchestrated & managed by Airflow, it is strongly
> recommended to use an external DB such as RDS. The Canso module creates a Postgres DB in RDS
> by default.

> [!IMPORTANT]
> Dependencies - Create a Security Group for RDS, which will then be used as an input in the 
> [`auto.tfvars`](./canso-dataplane-configs/rds/auto.tfvars) file

To create the RDS DB instance, navigate to the `canso-rds` module directory and run the following Terraform commands:

```console
cd modules/canso-rds
terraform init -backend-config=../../canso-dataplane-configs/rds/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/rds/auto.tfvars
```

---

### Step 6 - AWS S3

1. Update the S3 bucket and DynamoDB table details in [`backend.conf`](./canso-dataplane-configs/s3/backend.conf) if needed.
2. Update the [`auto.tfvars`](./canso-dataplane-configs/s3/auto.tfvars) file if needed.

> [!WARNING]
> DO NOT CHANGE THE BUCKET NAMES
> [`auto.tfvars`](./canso-dataplane-configs/s3/auto.tfvars) file

To create the S3 buckets, navigate to the `canso-s3` module directory and run the following Terraform commands:

```console
cd modules/canso-s3
terraform init -backend-config=../../canso-dataplane-configs/s3/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/s3/auto.tfvars
```

---

## Roadmap

- [ ] AWS EKS - Currently in progress
- [ ] GCP GKE
- [ ] Azure AKS