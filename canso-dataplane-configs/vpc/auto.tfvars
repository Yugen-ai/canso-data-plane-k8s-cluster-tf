region = "ap-south-1"

env             = "canso-dataplane-env"
vpc_cidr_block  = "10.4.0.0/16"
azs             = ["ap-south-1a", "ap-south-1b"]
private_subnets = ["10.4.0.0/19", "10.4.32.0/19"]
public_subnets  = ["10.4.64.0/19", "10.4.96.0/19"]

private_subnet_tags = {
  "kubernetes.io/role/internal-elb"               = 1
  "kubernetes.io/cluster/canso-dataplane-cluster" = "owned"
  "karpenter.sh/discovery"                        = "canso-dataplane-cluster"
}

public_subnet_tags = {
  "kubernetes.io/role/elb"                        = 1
  "kubernetes.io/cluster/canso-dataplane-cluster" = "owned"
}
