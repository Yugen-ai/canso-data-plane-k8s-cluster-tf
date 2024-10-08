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
- `canso-s3`


## Integration with Canso Platform Helm Charts

Canso Applications are deployed in your EKS cluster (also called the data plane) as [ArgoCD applications/applicationsets](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/), which in turn install and manage a bunch of [Helm charts](https://helm.sh/). When you log into the Canso Web app, the onboarding flow asks for certain inputs, some of which reference the resources created using the terraform modules present in this repo. It is therefore mandatory that the names of these resources generated using terraform provisioning and the values needed during helm installation match. The table below lists those resources and their default values.

> [!CAUTION]
> At the time of onboarding, you'll see a section in the Web app called **Role ARNs**. This section is a dictionary with keys = Component & values = IAM Role Value (Default) from the table below.
> While [creating these IRSA Roles (See Step 3)](./README.md#step-3---aws-irsa-roles) if you've made any changes to the names of these roles, make sure to provide the same names, else Canso components will not get installed successfully.

| Component                      | IRSA Name                                         | IAM Role Value (Default)                                                             |
|--------------------------------|---------------------------------------------------|--------------------------------------------------------------------------------------|
| `node_role`                    | `canso-dataplane-cluster-node-role`               | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-cluster-node-role`               |
| `aws_load_balancer_controller` | `canso-dataplane-alb-controller-irsa-role`        | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-alb-controller-irsa-role`        |
| `canso_karpenter`              | `canso-dataplane-karpenter-prod-irsa-role`        | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-karpenter-prod-irsa-role`        |
| `external_secrets`             | `canso-dataplane-external-secrets-prod-irsa-role` | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-external-secrets-prod-irsa-role` |
| `aws_ebs_csi_driver`           | `canso-dataplane-ebs-csi-prod-irsa-role`          | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-ebs-csi-prod-irsa-role`          |
| `aws_efs_csi_driver`           | `canso-dataplane-efs-csi-prod-irsa-role`          | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-efs-csi-prod-irsa-role`          |
| `spark`                        | `canso-dataplane-spark-s3-irsa-role`              | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-spark-s3-irsa-role`              |
| `canso_agent`                  | `devagent-dataplane-irsa-role`                    | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/devagent-dataplane-irsa-role`                    |
| `canso_airflow`                | `airflow-canso-dataplane-irsa-role`               | `arn:aws:iam::<AWS_ACCOUNT_ID>:role/airflow-canso-dataplane-irsa-role`               |

> [!CAUTION]
> In the Canso UI, the you'll see a section which has the following JSON as the default. This is in line with the values in the table above. If you've made changes to IRSA roles during Terraform setup, please edit the values in the code block accordingly.

```json
{
  "node_role" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-cluster-node-role",
  "aws_load_balancer_controller" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-alb-controller-irsa-role",
  "canso_karpenter" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-karpenter-prod-irsa-role",
  "external_secrets" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-external-secrets-prod-irsa-role",
  "aws_ebs_csi_driver" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-ebs-csi-prod-irsa-role",
  "aws_efs_csi_driver" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-efs-csi-prod-irsa-role",
  "spark" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/canso-dataplane-spark-s3-irsa-role",
  "canso_agent" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/devagent-dataplane-irsa-role",
  "canso_airflow" : "arn:aws:iam::<AWS_ACCOUNT_ID>:role/airflow-canso-dataplane-irsa-role"
}
```


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
> 1. `vpc_module_public_subnet_ids`: The public subnet IDs of the VPC
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

> [!CAUTION]
> If you change the cluster name, ensure you update the same in the rest of the configs, especially the IRSA roles.
> For e.g Each IRSA role has a `cluster_service_accounts` variable that uses the cluster name.

Any ingress rules(for the VPC security group) or additional rules(for the EKS security group) can be added as follows:
```
additional_security_group_rules = [
  {
    type                     = "ingress"
    from_port                = 30000
    to_port                  = 32767
    protocol                 = "tcp"
    source_security_group_id = "sg-xxxxxxxxxxxxxxxxxxxxx"  
    description              = "Allow security group to access the EKS security group"
  }
]

vpc_ingress_rules = [
  {
    description     = "Allow HTTP from anywhere"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
]
```

> [!CAUTION]
> Removing any previous ingress rules applied will not be detected by terraform. This is due to a known issue -  https://github.com/hashicorp/terraform-provider-aws/issues/4399 This will be fixed in a later release. Users can remove the ingress rules from the security group manually if needed.


---

### Step 3 - AWS IRSA Roles

> [!CAUTION]
> Please read the section on [IRSA role names](./README.md#integration-with-canso-platform-helm-charts)
> TL;DR - Strongly recommend not changing the names of IRSA roles for quicker helm chart installation.

We create the following IRSA roles in this step, each of which are in separate modules.

| IRSA Component   | Path to TfVars File                                                              | Path to conf file                                                               |
|------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| ALB Controller   | [Tfvars File](./canso-dataplane-configs/irsa-roles/alb-controller/auto.tfvars)   | [Conf File](./canso-dataplane-configs/irsa-roles/alb-controller/backend.conf)   |
| Karpenter        | [Tfvars File](./canso-dataplane-configs/irsa-roles/karpenter/auto.tfvars)        | [Conf File](./canso-dataplane-configs/irsa-roles/karpenter/backend.conf)        |
| External Secrets | [Tfvars File](./canso-dataplane-configs/irsa-roles/external-secrets/auto.tfvars) | [Conf File](./canso-dataplane-configs/irsa-roles/external-secrets/backend.conf) |
| EBS Driver       | [Tfvars File](./canso-dataplane-configs/irsa-roles/ebs-driver/auto.tfvars)       | [Conf File](./canso-dataplane-configs/irsa-roles/ebs-driver/backend.conf)       |
| EFS Driver       | [Tfvars File](./canso-dataplane-configs/irsa-roles/efs-driver/auto.tfvars)       | [Conf File](./canso-dataplane-configs/irsa-roles/efs-driver/backend.conf)       |
| Spark IRSA       | [Tfvars File](./canso-dataplane-configs/irsa-roles/spark/auto.tfvars)            | [Conf File](./canso-dataplane-configs/irsa-roles/spark/backend.conf)            |
| Canso Agent IRSA | [Tfvars File](./canso-dataplane-configs/irsa-roles/canso-agent/auto.tfvars)      | [Conf File](./canso-dataplane-configs/irsa-roles/canso-agent/backend.conf)      |
| Airflow IRSA     | [Tfvars File](./canso-dataplane-configs/irsa-roles/airflow/auto.tfvars)          | [Conf File](./canso-dataplane-configs/irsa-roles/airflow/backend.conf)          |

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

> [!IMPORTANT]
> **Dependencies**:
> Update the Canso account ID in the
> [`auto.tfvars`](./canso-dataplane-configs/irsa-roles/canso-agent/auto.tfvars) file,
> will be provided by the Canso Team.


```console
cd modules/canso-irsa
terraform init -backend-config=../../canso-dataplane-configs/irsa-roles/canso-agent/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/irsa-roles/canso-agent/auto.tfvars
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
> **Dependencies**:
> 1. Create a Security Group for RDS, which will then be used as an input in the 
> [`auto.tfvars`](./canso-dataplane-configs/rds/auto.tfvars) file
> 2. Create a [KMS](https://aws.amazon.com/kms/) key for RDS, This key will be referenced in the
> [`auto.tfvars`](./canso-dataplane-configs/rds/auto.tfvars) file and used in the KMS encrypt command mentioned in the
> [`db-creds.yaml`](./canso-dataplane-configs/rds/db-creds.yaml) file

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
> You should name your bucket such that it is [unique according to S3 naming requirements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html#:~:text=Bucket%20names%20must%20be%20unique%20across%20all%20AWS%20accounts%20in%20all%20the%20AWS%20Regions%20within%20a%20partition.%20A%20partition%20is%20a%20grouping%20of%20Regions.%20AWS%20currently%20has%20three%20partitions%3A%20aws%20(Standard%20Regions)%2C%20aws%2Dcn%20(China%20Regions)%2C%20and%20aws%2Dus%2Dgov%20(AWS%20GovCloud%20(US)).). 

For e.g. 

```console
{UNIQUE_TENANT_NAME}-canso-materialised-features
{UNIQUE_TENANT_NAME}-canso-materialised-logs
{UNIQUE_TENANT_NAME}-canso-materialised-artifacts
```

> [!IMPORTANT]
> Dependencies:
> Ensure you replace `UNIQUE_TENANT_NAME` with your actual value in the
> [`auto.tfvars`](./canso-dataplane-configs/rds/auto.tfvars) file

To create the S3 buckets, navigate to the `canso-s3` module directory and run the following Terraform commands:

```console
cd modules/canso-s3
terraform init -backend-config=../../canso-dataplane-configs/s3/backend.conf
terraform apply -no-color -auto-approve --var-file=../../canso-dataplane-configs/s3/auto.tfvars
```

> [!CAUTION]
> 1. Use the {UNIQUE_TENANT_NAME}-canso-materialised-features bucket for storing materialized features when registering sink details.
> 2. Provide the {UNIQUE_TENANT_NAME}-canso-materialised-logs bucket when generating the tenant dataplane YAML through the API.

---

### Step 7 - Secrets (in AWS Secrets Manager)

To pull Canso maintained images in your EKS, we use credentials that will be stored as secrets in your [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/). This helps authorised and secure access to all images needed to run Canso applications w/o exposing secrets.
  
The Canso team will provide you with dockerhub credentials, which must be added to your AWS secret manager. The secret should be in plain text format and have `aws/secretsmanager` as the encryption key.

```console
{"dockerhub":"{\"auths\":{\"https://index.docker.io/v1/\":{\"auth\":\"<GET VALUE FROM CANSO TEAM>>",\"email\":\"<GET VALUE FROM CANSO TEAM>",\"password\":\"<GET VALUE FROM CANSO TEAM>",\"username\":\"<GET VALUE FROM CANSO TEAM>"}}}"}
```

- [ ] Needs additional clarification, needs update
> Another instance where we use secrets are username password to access & log into the Airflow Web Server.

> The secret should be in following plain text format.

> ```console
> {"username":"db-name","password":"db-password"}
> ```

---

## Roadmap

- [ ] AWS EKS - Currently in progress
- [ ] GCP GKE
- [ ] Azure AKS
