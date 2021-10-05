// for level 1, level 2
module "vpc" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge"
  region = "ap-southeast-1"
  az = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  vpc_cidr = ""
  private_subnet_cidr = []
  public_subnet_cidr = []
  is_custom = false
}

// for level 3, custom subnets, both igw and nat-gateway will NOT be create, NO routing rules will be created
module "vpc" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge"
  region = "ap-southeast-1"
  az = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  vpc_cidr = ""
  private_subnet_cidr = []
  public_subnet_cidr = []
  is_custom = true
}


