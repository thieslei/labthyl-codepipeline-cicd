terraform {
  backend "s3" {
    bucket         = "thyl-tfstate-store"
    key            = "labthyl-codepipeline-cicd/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-table"
  }
}