resource "aws_codebuild_project" "smartcbt_codebuild" {
  name           = "smartcbt_codebuild"
  description    = "test description"
  build_timeout  = "30"
  queued_timeout = "480"

  service_role = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true

    # environment_variable {
    #   name  = "SOME_KEY1"
    #   value = "SOME_VALUE1"
    # }
  }

  #   logs_config {
  #   cloudwatch_logs {
  #     status = "smartcbt_log_monitor"
  #   }
  # }

  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.us-east-2.amazonaws.com/v1/repos/smartcbt_sample_test/master"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
#    version         = "master"
  }

  tags = {
    Name = "smartcbt_codebuild"
    Environment = "Production"
    Owner = "Product development team"
  }
}

resource "aws_iam_role" "example" {
  name = "example-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codecommit_policy" {
  name        = "codecommit-policy"
  description = "Policy that allows CodeBuild to pull from CodeCommit repositories"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart",
        "ecr:GetAuthorizationToken",
        "logs:CreateLogStream",
        "logs:*",
        "codebuild:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "codecommit_policy_attachment" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.codecommit_policy.arn
}


# {
# 	"Version": "2012-10-17",
# 	"Statement": [
# 		{
# 			"Sid": "Statement1",
# 			"Effect": "Allow",
# 			"Action": [
# 				"ecr:GetAuthorizationToken",
# 				"ecr:BatchCheckLayerAvailability",
# 				"ecr:CompleteLayerUpload",
# 				"ecr:InitiateLayerUpload",
# 				"ecr:PutImage",
# 				"ecr:UploadLayerPart",
# 				"ecr:GetAuthorizationToken",
# 				"logs:CreateLogStream",
# 				"logs:*",
# 				"codebuild:*"
# 			],
# 			"Resource": "*"
# 		}
# 	]
# }
