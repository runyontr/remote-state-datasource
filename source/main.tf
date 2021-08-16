# The following example shows how to generate a random priority
# between 1 and 50000 for a aws_alb_listener_rule resource:

resource "random_integer" "priority" {
  min = 1
  max = 50000
}


output "random" {
    value = random_integer.priority.result
}