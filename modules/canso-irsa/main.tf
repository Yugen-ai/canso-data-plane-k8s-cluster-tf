############################### 
## AWS IAM Policy
###############################

resource "aws_iam_policy" "policy" {
  count = var.create_policy ? 1 : 0

  name        = var.iam_policy_name
  path        = var.iam_policy_path
  description = var.iam_policy_description

  policy = var.dynamic_policy ? local.policy : var.iam_policy_policy

  tags = var.iam_policy_tags
}

############################### 
## Irsa Role
###############################

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "main" {
  for_each = var.cluster_service_accounts

  name = each.key
}

data "aws_iam_policy_document" "assume_role_with_oidc" {
  dynamic "statement" {
    for_each = var.cluster_service_accounts

    content {
      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity", "sts:AssumeRole"]

      principals {
        type = "Federated"

        identifiers = [
          "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}"
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = [for s in statement.value : "system:serviceaccount:${s}"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  assume_role_policy    = data.aws_iam_policy_document.assume_role_with_oidc.json
  description           = var.role_description
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  name                  = var.role_name
  name_prefix           = var.role_name_prefix
  path                  = var.role_path
  permissions_boundary  = var.role_permissions_boundary_arn
  tags                  = var.tags
}

locals {
  policy = var.dynamic_policy ? replace(var.iam_policy_policy, "ROLE_ARN_PLACEHOLDER", var.eks_node_role_arn) : var.iam_policy_policy
}

resource "aws_iam_role_policy_attachment" "custom" {
  count      = var.create_role && var.create_policy ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_role_policy_attachment" "managed" {
  count      = var.create_role ? length(var.managed_policy_arns) : 0
  role       = aws_iam_role.this[0].name
  policy_arn = element(tolist(var.managed_policy_arns), count.index)
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.policy[0].arn
}


resource "aws_iam_instance_profile" "this" {
  count = var.create_role && var.create_instance_profile ? 1 : 0
  name  = var.role_name
  path  = var.role_path
  role  = aws_iam_role.this[0].name

  tags = var.tags
}

data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.create_role && var.create_aws_iam_role_policy && var.create_instance_profile ? var.statements : []
    content {
      resources = statement.value.resources
      actions   = statement.value.actions
    }
  }
}

resource "aws_iam_role_policy" "main" {
  count  = var.create_role && var.create_aws_iam_role_policy && var.create_instance_profile ? 1 : 0
  name   = var.aws_iam_role_policy
  policy = data.aws_iam_policy_document.main.json
  role   = aws_iam_role.this[0].name
}
