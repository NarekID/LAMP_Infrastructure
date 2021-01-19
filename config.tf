terraform {
  backend "s3" {
    bucket = "terraform-tfstate-files-remote-s3-79686699"
    key = "terraform_statefiles/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking-ddb"
    encrypt = true
  }
}