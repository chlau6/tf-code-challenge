// for level 1, level 2
module "test1" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge-1"
  region = "ap-southeast-1"
  vpc_cidr = "10.0.0.0/26"
  is_custom = false
  private_subnet = [
    {
      "cidr": "10.0.0.0/28",
      "availability_zone": "ap-southeast-1a"
    },
    {
      "cidr": "10.0.0.16/28",
      "availability_zone": "ap-southeast-1b"
    }
  ]
  public_subnet = [
    {
      "cidr": "10.0.0.32/28",
      "availability_zone": "ap-southeast-1a"
    },
    {
      "cidr": "10.0.0.48/28",
      "availability_zone": "ap-southeast-1b"
    }
  ]
}

// for level 3, custom subnets, NO routing rules will be created
module "test2" {
  source = "./modules/terraform-aws-vpc"
  project = "code-challenge-2"
  region = "ap-southeast-1"
  vpc_cidr = "10.0.1.0/26"
  is_custom = true
  private_subnet = [
    {
      "cidr": "10.0.1.0/28",
      "availability_zone": "ap-southeast-1a"
    },
    {
      "cidr": "10.0.1.16/28",
      "availability_zone": "ap-southeast-1b"
    }
  ]
  public_subnet = [
    {
      "cidr": "10.0.1.32/28",
      "availability_zone": "ap-southeast-1a"
    },
    {
      "cidr": "10.0.1.48/28",
      "availability_zone": "ap-southeast-1b"
    }
  ]

#  igw_id = ""
#  nat_gw_id = ""

  // the above igw_id and nat_gw_id should be un-comment when we want to attach our subnet to an existing igw / nat gateway
}


