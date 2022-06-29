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

//TODO SG that has been created in this module has been manually updated by adding inbound rules to open 80 and 22 port. Migrate it to terraform!
//  default_security_group_ingress = [
//    {
//      from_port   = 80
//      to_port     = 80
//      protocol    = "-1"
//      cidr_blocks = ["0.0.0.0/0"]
//    }
//  ]

  tags = {
    owner    = "DNA Team"
    deployer = "Jakub Socha"
    stage    = "test"
  }
}


//TODO I am not sure if I understand correctly how NAT gateway is working, but I believe it is possible to deploy application within private subnets, NAT in public and route the traffic without expose application via public IP address
