variable "project_id" {
  type    = string
  default = "project-a-331710"
}
variable "machine" {
  type    = string
  default = "f1-micro"
}

variable "key" {
  type    = string
  default = "credentials.json"
}
variable "zone" {
  type    = string
  default = "us-central1-a"
}
variable "region" {
  type    = string
  default = "us-central1"
}

variable "startupscript" {
  type    = string
  default = "bootstrap.sh"
}