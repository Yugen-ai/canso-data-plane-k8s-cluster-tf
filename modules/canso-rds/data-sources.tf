data "aws_kms_secrets" "creds" {

  secret {
    name = "db"
    #payload = file("${path.module}/db-creds.yaml.encrypted")
    payload = file("${var.db_creds_path}")

  }
}

locals {
  db_creds = yamldecode(data.aws_kms_secrets.creds.plaintext["db"])
}
