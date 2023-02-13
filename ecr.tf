resource "aws_ecr_repository" "meetup_ecr_repo" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "meetup-ecr"
  }
}

resource "aws_ecr_lifecycle_policy" "meetup_ecr_repo" {
  repository = aws_ecr_repository.meetup_ecr_repo.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 5 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
    }]
  })
}

output "aws_ecr_repository_url" {
  value = aws_ecr_repository.meetup_ecr_repo.repository_url
}
