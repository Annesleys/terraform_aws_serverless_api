profile        = "aps"
region         = "eu-west-1"
cidr_block     = "10.10.0.0/16"
public_subnet  = ["10.10.0.0/24", "10.10.1.0/24"]
private_subnet = ["10.10.2.0/24", "10.10.3.0/24"]
env            = "dev" #### you can change the env according to your environmnet. values are dev and prod