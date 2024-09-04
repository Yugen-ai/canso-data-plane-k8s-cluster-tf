region = "us-east-1"

env             = "canso-dplane-v1-env"
vpc_cidr_block  = "10.4.0.0/16"
azs             = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.4.0.0/19", "10.4.32.0/19"]
public_subnets  = ["10.4.64.0/19", "10.4.96.0/19"]

private_subnet_tags = {
  "kubernetes.io/role/internal-elb"               = 1
  "kubernetes.io/cluster/canso-dplane-v1"         = "owned"
  "karpenter.sh/discovery"                        = "canso-dplane-v1"
}

public_subnet_tags = {
  "kubernetes.io/role/elb"                        = 1
  "kubernetes.io/cluster/canso-dplane-v1"         = "owned"
}
