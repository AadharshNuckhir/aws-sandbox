resource "aws_apigatewayv2_api" "presigned_url_http_api" {
name = "presigned_url_http_api"
protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "integration_presigned" {
  api_id           = aws_apigatewayv2_api.presigned_url_http_api.id
  description      = "http api gateway with lambda"
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.presigned_url.invoke_arn
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "uc08_route_presigned-url" {
  api_id    = aws_apigatewayv2_api.presigned_url_http_api.id
  route_key = "ANY /{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.integration_presigned.id}"
}

resource "aws_apigatewayv2_stage" "presigned_url_stage" {
  api_id = aws_apigatewayv2_api.presigned_url_http_api.id
  name   = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gw_presigned_url"{
  statement_id   = "AllowExecutionFromAPIGateway"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.presigned_url.function_name
  principal      = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.presigned_url_http_api.execution_arn}/*/*"
}