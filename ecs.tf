resource "aws_ecs_cluster" "main" {
  name = "abc-cluster"
}
resource "aws_ecs_task_definition" "task" {
  family                   = "abc-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
 
container_definitions = jsonencode([
  {
    name      = "abc-container"
    image     = "amazonlinux"
    cpu       = 256
    memory    = 512
    essential = true
 
    command = [
      "sh",
      "-c",
      "echo ECS task completed; sleep 5"
    ]
  }
])
} 
