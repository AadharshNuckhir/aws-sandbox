terraform {
  backend "s3" {
    bucket = "terraform-state-folder"
    key    = "presigned-url/terraform.tfstate"
    region = "eu-central-1"
  }
}