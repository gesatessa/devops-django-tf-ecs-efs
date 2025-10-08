resource "aws_ecr_repository" "api" {
  name                 = "${local.prefix}-api-repo"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    # in production, set this to true
    scan_on_push = false
  }

}


resource "aws_ecr_repository" "proxy" {
  name                 = "${local.prefix}-proxy-repo"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    # in production, set this to true
    scan_on_push = false
  }

}


data "aws_iam_policy_document" "ecr" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
    resources = [
      aws_ecr_repository.api.arn,
      aws_ecr_repository.proxy.arn,
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr" {
  name        = "${local.prefix}-ecr-policy"
  description = "Policy to allow pushing images to ECR repositories"
  policy      = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_user_policy_attachment" "ecr" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ecr.arn
}

