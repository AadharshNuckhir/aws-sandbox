######Create a lambda function for presigned
resource "aws_lambda_function" "presigned_url" {
  function_name = "presigned-url"
  role          =  "arn:aws:iam::496051641293:role/aadharsh-role"
  image_uri     = "496051641293.dkr.ecr.eu-central-1.amazonaws.com/presigned-url:latest"
  timeout       = 30 # seconds
  package_type  = "Image"
  environment {
    variables = {
    S3_BUCKET_INVOICE_PSN = "aadharsh_s3"
    S3_BUCKET_INVOICE = "aadharshtest"
    TIME_TO_LIVE = "2"
   }
}
}