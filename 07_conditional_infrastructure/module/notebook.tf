resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                   = var.notebook_name
  role_arn               = data.aws_ssm_parameter.iam_role.value
  instance_type          = (var.environment == "dev" ? "ml.t2.medium" : "ml.g4dn.xlarge")
  security_groups        = [data.aws_ssm_parameter.security_group_id.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id.value
  direct_internet_access = "Disabled"
}