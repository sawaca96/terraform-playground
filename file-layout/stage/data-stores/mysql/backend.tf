terraform {
  backend "s3" {
    bucket         = "sawaca96-terraform-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
    profile        = "terraform-up"
  }
}
