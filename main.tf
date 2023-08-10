terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
//  shared_config_files      = ["/Users/devavrat.oka/.aws/config"]
//  shared_credentials_files = ["/Users/devavrat.oka/.aws/credentials"]
//  profile                  = "default"
}

// Create the S3 bucket which will be used for storing remote state. 
// Create the bucket with accidental deletion prevention turned on.
// To delete bucket, set to false or comment out.

resource "aws_s3_bucket" "doka_terraform_state" {
  bucket = "doka_terraform_state"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

// This enables versioning on the file so previous state files can be stored in case user wants to revert to an older state.

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.doka_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

// Enable server side encryption on by default for all data stored in the S3 bucket.
// In case there are any secrets stored in code they will be encrypted in the state file.

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.doka_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

// Because the S3 buckets store state and secrets which are sensitive data, this bucket should not be publicly accessible.
// This step blocls public access.

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.doka_terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// DynamodDB is a key-value store with strongly consistent reads and writes, which are required for maintaining a locking system. 
// The table must have a partition key named LockID with type of String.

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
