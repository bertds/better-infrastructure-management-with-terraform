// TO DO: create multiple secure notebooks by making use of the count and for_each keywords

locals {
  Users = tolist(["Alice", "Bob", "Chris", "Diana", "Erin"])
  User_set = toset(local.Users)
  Instance_type = tolist(["ml.t2.medium", "ml.p2.xlarge", "ml.t2.medium", "ml.t3.medium", "ml.t2.medium"])
  IP = tolist(["1.1.1.1", "1.1.1.2", "1.1.1.3", "1.1.1.4", "1.1.1.5"])
  zip1 = zipmap(local.Users, local.Instance_type)
  zip2 = zipmap(local.Users, local.IP)
}

module "secure_notebooks" {
  count = length(local.Users)
  source        = "./secure_notebook"
  ip_address    = local.IP[count.index]
  notebook_name = "single-notebook-${local.Users[count.index]}"
  instance_type = local.Instance_type[count.index]
}

module "secure_notebooks2" {
  for_each = local.User_set
  source        = "./secure_notebook"
  ip_address    = local.IP[index(local.Users, each.key)]
  notebook_name = "single-notebook-${each.key}-2"
  instance_type = local.Instance_type[index(local.Users, each.key)]
}