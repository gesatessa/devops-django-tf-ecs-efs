resource "aws_iam_user" "cd" {
  name = "${local.prefix}-cd-user"
}

resource "aws_iam_access_key" "cd" {
  user = aws_iam_user.cd.name
}

resource "aws_iam_policy" "tf-backend" {
  name        = "${aws_iam_user.cd.name}-tf-backend-policy"
  description = "Policy to allow access to the terraform backend S3 bucket and DynamoDB table"
  policy      = data.aws_iam_policy_document.terraform_backend.json
}

resource "aws_iam_user_policy_attachment" "tf-backend" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf-backend.arn

}

data "aws_iam_policy_document" "terraform_backend" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.tf_state_bucket}",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${var.tf_state_bucket}/deploy/*",
      #   "arn:aws:s3:::${var.tf_state_bucket}/deploy-env/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/${var.tf_state_lock_table}",
    ]
  }
}
