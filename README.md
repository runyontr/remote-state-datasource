# Terraform state


## Source

In order for another terraform run to read data from a statefile, it needs to be available as an `output`.  In the `source folder, we create a statefile that has a single number as an output:

```bash
❯ cd source   
❯ tf apply 

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_integer.priority will be created
  + resource "random_integer" "priority" {
      + id     = (known after apply)
      + max    = 50000
      + min    = 1
      + result = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + random = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_integer.priority: Creating...
random_integer.priority: Creation complete after 0s [id=24906]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

random = 24906
❯ tf output
random = 24906
```

Created a random number of 24906 that we will read in the following section

## Reading

Reading from a statefile requires the use of a [Remote State Datasource](https://www.terraform.io/docs/language/state/remote-state-data.html).  The example here reads from a local file, but a remote backend (e.g. s3) is also allowed.

This terraform reads from the other state file and prints off the same random number:


```bash
❯ cd read  
❯ tf apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.example1 will be created
  + resource "null_resource" "example1" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

null_resource.example1: Creating...
null_resource.example1: Provisioning with 'local-exec'...
null_resource.example1 (local-exec): Executing: ["/bin/sh" "-c" "echo Random Number: $OUTPUT"]
null_resource.example1 (local-exec): Random Number: 24906
null_resource.example1: Creation complete after 0s [id=2995480828739082113]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
