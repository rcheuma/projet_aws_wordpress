terraform {
  backend "s3" {
    bucket = "myfirstbucket-231220"
    key    = "terraform.tfstate"
    # kms_key_id     = "alias/simplon-devops-b2-tf-backend-groupe2"
    region  = "us-east-1"
    encrypt = true
    # dynamodb_table = "simplon-devops-b2-tf-backend-groupe2"
    profile = "formation"
    #role_arn       = "arn:aws:iam::085586464868:role/simplon-devops-b2-tf-backend-groupe2_access"
  }
}