resource "aws_iam_role" "codepipeline_role" {
  name = "tf-core-CodePipelineRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "tf-core-CodePipelinePolicy"
  role = aws_iam_role.codepipeline_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:*", "iam:PassRole", "codebuild:StartBuild", "codestar-connections:UseConnection", "codebuild:BatchGetBuilds"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role" "codebuild_role" {
  name = "tf-core-CodeBuildRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "tf-core-CodeBuildPolicy"
  role = aws_iam_role.codebuild_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["logs:*", "s3:*", "codecommit:*", "codebuild:*", "ssm:GetParameters", "kms:Decrypt"]
      Resource = "*"
    }]
  })
}