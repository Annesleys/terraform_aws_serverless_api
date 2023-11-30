resource "aws_api_gateway_rest_api" "MyApi" {
  name        = "ServerlessApi"
  description = "Rest api"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.MyApi.id
  parent_id   = aws_api_gateway_rest_api.MyApi.root_resource_id
  path_part   = "myresource"
}

# resource "aws_api_gateway_method" "MyMethod" {
#   rest_api_id   = aws_api_gateway_rest_api.MyApi.id
#   resource_id   = aws_api_gateway_resource.MyApi.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id             = aws_api_gateway_rest_api.MyApi.id
#   resource_id             = aws_api_gateway_resource.resource.id
#   http_method             = aws_api_gateway_method.method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.lambda.invoke_arn
# }