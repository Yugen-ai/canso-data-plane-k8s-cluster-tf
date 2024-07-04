provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.demo.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)
}
