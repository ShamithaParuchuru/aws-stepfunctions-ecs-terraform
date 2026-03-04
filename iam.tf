resource "aws_iam_role" "step_role" {
  name = "abc-step-function-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
 
# Allow Step Functions to run ECS tasks
resource "aws_iam_role_policy_attachment" "step_ecs_policy" {
  role       = aws_iam_role.step_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
 
# Allow Step Functions to access EC2
resource "aws_iam_role_policy_attachment" "step_ec2_policy" {
  role       = aws_iam_role.step_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
 
# Allow Step Functions to write logs
resource "aws_iam_role_policy_attachment" "step_logs_policy" {
  role       = aws_iam_role.step_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
 
