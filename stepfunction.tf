resource "aws_sfn_state_machine" "workflow" {
  name     = "abc-workflow-v2"
  role_arn = aws_iam_role.step_role.arn
 
  definition = jsonencode({
    Comment = "ABC Startup Transaction Processing Workflow"
    StartAt = "CheckEC2"
 
    States = {
 
      CheckEC2 = {
        Type = "Pass"
        Result = "EC2 instance validated"
        Next = "RunECSTask"
      }
 
      RunECSTask = {
        Type = "Task"
        Resource = "arn:aws:states:::ecs:runTask.sync"
 
        Parameters = {
          LaunchType = "FARGATE"
 
          Cluster = aws_ecs_cluster.main.id
 
          TaskDefinition = aws_ecs_task_definition.task.arn
 
NetworkConfiguration = {
  AwsvpcConfiguration = {
    Subnets = [
      aws_subnet.public.id
    ]
 
    SecurityGroups = [
      aws_security_group.ec2_sg.id
    ]
 
    AssignPublicIp = "ENABLED"
  }
}        }
 
        End = true
      }
 
    }
  })
}
