resource "aws_apigatewayv2_api" "lambda_api" {
    name          = "v2-http-api"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda_stage" {
    api_id      = aws_apigatewayv2_api.lambda_api.id
    name        = "$default"
    auto_deploy = true
}

# getUsers
resource "aws_apigatewayv2_integration" "getUsers_integration" {
    api_id           = aws_apigatewayv2_api.lambda_api.id
    integration_type = "AWS_PROXY"

    integration_method   = "POST"
    integration_uri      = aws_lambda_function.getUsers.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "getUsers_route" {
    api_id             = aws_apigatewayv2_api.lambda_api.id
    route_key          = "GET /"
    target             = "integrations/${aws_apigatewayv2_integration.getUsers_integration.id}"
}

resource "aws_lambda_permission" "getUsers_api_permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.getUsers.arn
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

# getUser {ID}
resource "aws_apigatewayv2_integration" "getUser_integration" {
    api_id           = aws_apigatewayv2_api.lambda_api.id
    integration_type = "AWS_PROXY"

    integration_method   = "POST"
    integration_uri      = aws_lambda_function.getUser.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "getUser_route" {
    api_id             = aws_apigatewayv2_api.lambda_api.id
    route_key          = "GET /{ID}"
    target             = "integrations/${aws_apigatewayv2_integration.getUser_integration.id}"
}

resource "aws_lambda_permission" "getUser_api_permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.getUser.arn
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

# createUser
resource "aws_apigatewayv2_integration" "createUser_integration" {
    api_id           = aws_apigatewayv2_api.lambda_api.id
    integration_type = "AWS_PROXY"

    integration_method   = "POST"
    integration_uri      = aws_lambda_function.createUser.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "createUser_route" {
    api_id             = aws_apigatewayv2_api.lambda_api.id
    route_key          = "POST /"
    target             = "integrations/${aws_apigatewayv2_integration.createUser_integration.id}"
}

resource "aws_lambda_permission" "createUser_api_permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.createUser.arn
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

# deleteUser {ID}
resource "aws_apigatewayv2_integration" "deleteUser_integration" {
    api_id           = aws_apigatewayv2_api.lambda_api.id
    integration_type = "AWS_PROXY"

    integration_method   = "POST"
    integration_uri      = aws_lambda_function.deleteUser.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "deleteUser_route" {
    api_id             = aws_apigatewayv2_api.lambda_api.id
    route_key          = "DELETE /{ID}"
    target             = "integrations/${aws_apigatewayv2_integration.deleteUser_integration.id}"
}

resource "aws_lambda_permission" "deleteUser_api_permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.deleteUser.arn
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}