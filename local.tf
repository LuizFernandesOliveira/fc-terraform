resource "local_file" "example" {
  filename = "example.txt"
  content  = var.content
}

data "local_file" "example" {
  filename = "example.txt"
}

output "data-source-result" {
  value = data.local_file.example.content
}

variable "content" {
  type = string
}

output "id-file" {
  value = resource.local_file.example.id
}