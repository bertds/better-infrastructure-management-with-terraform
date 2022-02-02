# use the input variables to configure the notebook

resource "aws_sagemaker_notebook_instance" "modular_notebook" {
  name          = var.notebook_name
  role_arn      = aws_iam_role.role.arn
  instance_type = var.instance_type
  security_groups = 
  subnet_id = 
}