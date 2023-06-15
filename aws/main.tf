module "demo_vpc" {
  source   = "./modules/networking"
  vpc_cidr = "10.200.0.0/16"
  public_cidrs = ["10.0.0.16/24", "10.0.1.0/24"]

}