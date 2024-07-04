data "tls_certificate" "eks" {
  url = aws_eks_cluster.demo.identity[0].oidc[0].issuer
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.demo.name
}


