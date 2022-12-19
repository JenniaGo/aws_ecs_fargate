# Output the URL of the load balancer created by the ECS service
output "load_balancer_url" {
  value = "${aws_ecs_service.ecs_service.load_balancer.ingress[0].hostname}"
}
