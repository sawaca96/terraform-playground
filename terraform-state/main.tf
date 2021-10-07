provider "aws" {
  region  = "ap-northeast-2"
  profile = "terraform-up"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket        = "sawaca96-terraform-state"
  force_destroy = true # 버켓이 empty가 아니어도 삭제함

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

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
