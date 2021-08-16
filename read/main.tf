data "terraform_remote_state" "random" {
  backend = "local"

  config = {
    path = "../source/terraform.tfstate"
  }
}



 resource "null_resource" "example1" {
  provisioner "local-exec" {
    command = "echo Random Number: $OUTPUT"
    environment = {
      OUTPUT = data.terraform_remote_state.random.outputs.random
     }
  }
}