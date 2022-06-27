module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dna-base-eu"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  //TODO Enable NAT configuration (disabled due to costs in development phase :))
  //  enable_nat_gateway = true
  //  enable_vpn_gateway = true

  tags = {
    owner = "DNA Team"
    deployer = "Jakub Socha"
    stage = "test"
  }
}


//ECS cluster
//ECS Service
//ECS task definition
//Fargate vs EC2? Terraform registry for Fargate?

//Rotue53 -> terraform registry?


