locals {
  ## private subnets
  #private_subnet_ids = { for k, v in module.vpc["main"].private_subnets : k => tomap({ "id"= v.id ,"availability_zone" = v.availability_zone})}
  #private_subnet_ids = [ for k, v in module.vpc["main"].private_subnets : v.id]
  db_subnet_ids = tolist([module.vpc["main"].private_subnets["db_az1"].id, module.vpc["main"].private_subnets["db_az2"].id ])

}