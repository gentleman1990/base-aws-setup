data "aws_iam_role" "ecs" {
  name = "aws_iam_role"
}

resource "aws_ecs_cluster" "dna" {
  name = "simple-app"
}

resource "aws_ecs_service" "dna" {
  name            = "simple-service"
  cluster         = aws_ecs_cluster.dna.name
  task_definition = aws_ecs_task_definition.simple_app.arn
  desired_count   = 2
}

//TODO template can be further parametrized to make it more generic and usable for other services or even as module
resource "aws_ecs_task_definition" "simple_app" {
  family                = "simple-service-task-definition"
  container_definitions = file("${path.module}/task-definition/ecs_task_definition.json")

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    owner    = "DNA Team"
    deployer = "Jakub Socha"
    stage    = "test"
  }
}

//ECS cluster
//ECS Service
//ECS task definition
//Fargate vs EC2? Terraform registry for Fargate?

//Rotue53 -> terraform registry?