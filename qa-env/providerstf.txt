terraform {
  required_providers {
   aws = {
     source = "hashicorp/aws"
   }
 }
}

provider "aws" {
  region = "ap-south-1"
}

#Note : There should be only one Terraform provider block.  