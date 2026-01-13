resource "aws_lambda_function" "app" {
  function_name = "rails-lambda-processor"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  # Placeholder image until the first build pushes a real one.
  # Using a public hello-world image to allow initial apply to succeed.
  # Alternatively, we can use the ECR repo URL but it will fail if empty.
  # We will use the ECR repository URL, assuming the user will push before apply or we accept failure on first apply.
  # Ideally, we use a null_resource to push a dummy image, but for simplicity:
  image_uri     = "${aws_ecr_repository.app_repo.repository_url}:latest"

  timeout     = 60
  memory_size = 512

  environment {
    variables = {
      RAILS_ENV = "production"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_iam_role_policy.sqs_policy
  ]
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.job_queue.arn
  function_name    = aws_lambda_function.app.arn
  batch_size       = 1
  enabled          = true
}
