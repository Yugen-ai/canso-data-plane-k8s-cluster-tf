resource "aws_s3_bucket" "this" {
  for_each = { for bucket in var.buckets : bucket => bucket }

  bucket        = each.value
  force_destroy = var.force_destroy

  tags = merge(
    {
      "Name" = each.key
    },
    {
      "canso.ai/product-component" = "app-dependencies",
      "canso.ai/service"           = "s3"
    }
  )
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  for_each = { for bucket in var.buckets : bucket => bucket }

  bucket     = aws_s3_bucket.this[each.key].id
  acl        = var.bucket_acl
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  for_each = { for bucket in var.buckets : bucket => bucket }

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = { for bucket in var.buckets : bucket => bucket }

  bucket = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = { for bucket in var.buckets : bucket => bucket }

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    id     = "Transition and Expiration"
    status = var.lifecycle_rule_enabled ? "Enabled" : "Disabled"

    transition {
      days          = var.transition_days
      storage_class = var.transition_storage_class
    }

    expiration {
      days = var.expiration_days
    }
  }
}
