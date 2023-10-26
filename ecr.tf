resource "aws_ecr_repository" "smartcbt_test" {
  name                 = "smartcbt_test"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "smartCBT private ECR for candidate backend"
    Environment = "Production"
    Owner       = "Product development team"
  }
}
