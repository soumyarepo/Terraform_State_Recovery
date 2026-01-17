terraform {
  backend "s3" {
    bucket         = "terraform-state-recovery-demo"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
