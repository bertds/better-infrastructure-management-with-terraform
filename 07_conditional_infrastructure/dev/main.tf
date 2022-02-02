module "secure_notebooks" {
  source        = "../module"

  environment   = "dev"
  notebook_name = "single-notebook"
  
}