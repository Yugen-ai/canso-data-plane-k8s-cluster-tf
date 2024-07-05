output "s3_buckets_info" {
  value = { for bucket in var.buckets : bucket => {
    id  = aws_s3_bucket.this[bucket].id,
    arn = aws_s3_bucket.this[bucket].arn
  } }
}
