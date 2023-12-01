resource "aws_iam_role" "lambda_role" {
  name               = "Lambda_Function_Role${var.env}"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role${var.env}"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

///////////////////////

resource "null_resource" "dummy_artifact" {
  provisioner "local-exec" {
    command = "${path.module}/dummy.sh"

    environment = {
      artifact_name = "${var.artifact_name}.zip"
      bucket_name   = var.s3_bucket
    }

    interpreter = [
      "bash",
      "-c"
    ]
  }
}

resource "aws_lambda_function" "terraform_lambda_func" {
  s3_bucket     = var.s3_bucket
  s3_key        = "${var.artifact_name}.zip"
  function_name = "Lambda_Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "${var.artifact_name}.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role, null_resource.dummy_artifact]
}
