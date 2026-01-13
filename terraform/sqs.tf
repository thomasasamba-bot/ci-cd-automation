resource "aws_sqs_queue" "job_queue" {
  name                       = "rails-job-queue"
  visibility_timeout_seconds = 60 # Must be >= Lambda timeout
  message_retention_seconds  = 86400
}

output "queue_url" {
  value = aws_sqs_queue.job_queue.id
}

output "queue_arn" {
  value = aws_sqs_queue.job_queue.arn
}
