data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "MyApi" {
  name        = "ServerlessApi"
  description = "Rest api"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.MyApi.id
  parent_id   = aws_api_gateway_rest_api.MyApi.root_resource_id
  path_part   = "status"
}

resource "aws_api_gateway_method" "MyMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyApi.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.MyApi.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.MyMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lamda_invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.MyApi.id}/*/${aws_api_gateway_method.MyMethod.http_method}${aws_api_gateway_resource.resource.path}"
}

resource "aws_api_gateway_deployment" "my_deployment" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.MyApi.id
  stage_name  = var.env # Set your desired stage name
}