module "codecommit_smartcbt_sample_test" {
  source          = "lgallard/codecommit/aws"
  repository_name = "smartcbt_sample_test"
  description     = "smartcbt_sample_test repository"
  default_branch  = "master"
  tags = {
    Name        = "smartcbt_sample_test Code Commit"
    Environment = "Production"
    Owner       = "Product development team"
  }
}
