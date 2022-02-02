module "secure_notebooks" {
  source        = "../module"

  environment   = "prod"
  notebook_name = "single-notebook"
  
}