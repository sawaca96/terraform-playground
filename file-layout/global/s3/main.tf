provider "aws" {
  region  = "ap-northeast-2"
  profile = "terraform-up"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.bucket_name
  force_destroy = true

  versioning {
    enabled = true
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}



resource "aws_dynamodb_table" "terrform_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "LockID"
    type = "S"
  }
}
