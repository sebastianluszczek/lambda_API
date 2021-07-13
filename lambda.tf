# S3 bucket
resource "aws_s3_bucket" "sls_api_storage" {
  bucket = "slsapistorage-1234321"
  acl = "private"
  tags = {
    Name = "sls_api_storage-1"
  }
}

# pack lambdas locally
data "archive_file" "local_zip_getUsers" {
  source_file = "${path.module}/dist/getUsers.js"
  type = "zip"
  output_path = "${path.module}/dist/getUsers.zip"
}

data "archive_file" "local_zip_getUser" {
  source_file = "${path.module}/dist/getUser.js"
  type = "zip"  
  output_path = "${path.module}/dist/getUser.zip"
}

data "archive_file" "local_zip_createUser" {
  source_file = "${path.module}/dist/createUser.js"
  type = "zip"
  output_path = "${path.module}/dist/createUser.zip"
}

data "archive_file" "local_zip_deleteUser" {
  source_file = "${path.module}/dist/deleteUser.js"
  type = "zip"
  output_path = "${path.module}/dist/deleteUser.zip"
}

# upload files to S3 bucket
resource "aws_s3_bucket_object" "zip_getUsers" {
  bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  key = "getUsers.zip"
  source = "${path.module}/dist/getUsers.zip"
}

resource "aws_s3_bucket_object" "zip_getUser" {
  bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  key = "getUser.zip"
  source = "${path.module}/dist/getUser.zip"
}

resource "aws_s3_bucket_object" "zip_createUser" {
  bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  key = "createUser.zip"
  source = "${path.module}/dist/createUser.zip"
}

resource "aws_s3_bucket_object" "zip_deleteUser" {
  bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  key = "deleteUser.zip"
  source = "${path.module}/dist/deleteUser.zip"
}

# create lambdas
resource "aws_lambda_function" "getUsers" {
  function_name = "getUsers"

  s3_bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  s3_key    = "${aws_s3_bucket_object.zip_getUsers.key}"

  handler     = "getUsers.handler"
  runtime     = "nodejs12.x"
  role        = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_lambda_function" "getUser" {
  function_name = "getUser"

  s3_bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  s3_key    = "${aws_s3_bucket_object.zip_getUser.key}"

  handler     = "getUser.handler"
  runtime     = "nodejs12.x"
  role        = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_lambda_function" "createUser" {
  function_name = "createUser"

  s3_bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  s3_key    = "${aws_s3_bucket_object.zip_createUser.key}"

  handler     = "createUser.handler"
  runtime     = "nodejs12.x"
  role        = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_lambda_function" "deleteUser" {
  function_name = "deleteUser"

  s3_bucket = "${aws_s3_bucket.sls_api_storage.bucket}"
  s3_key    = "${aws_s3_bucket_object.zip_deleteUser.key}"

  handler     = "deleteUser.handler"
  runtime     = "nodejs12.x"
  role        = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

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

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = "${aws_iam_role.lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      "Resource": "arn:aws:dynamodb:eu-central-1:247826688291:table/myDB"
    }
  ]
}
EOF
}