terraform {
  backend "s3" {
    bucket         = "eks-gitops-nodejs-terraform-state-197103521954"
    key            = "eks-gitops-nodejs-platform/dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "eks-gitops-nodejs-terraform-locks"
    encrypt        = true
  }
}
