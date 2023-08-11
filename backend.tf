terraform {
  backend "s3" {
    bucket = "doka-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

// To remove remote backend, remove the backend.tf file and rerun terraform init
// No variables in this file
// Use unique key
