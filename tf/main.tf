// for level 1, level 2
module "vpc" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge"
  region = "ap-southeast-1"
  vpc_cidr = ""
  is_custom = false
  private_subnet = [
    {
      "cidr": "",
      "availability_zone": "ap-southeast-1"
    }
  ]
  public_subnet = []
}

// for level 3, custom subnets, NO routing rules will be created
module "vpc" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge"
  region = "ap-southeast-1"
  vpc_cidr = ""
  private_subnet_cidr = []
  public_subnet_cidr = []
  is_custom = true
  private_subnet = []
  public_subnet = []
}


