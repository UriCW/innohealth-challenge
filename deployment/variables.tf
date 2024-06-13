variable "project_name" {
  type = string
  description = "The Google Cloud Project Name"
}

variable "region" {
  description = "The Google Cloud region, example europe-southwest1"
  default = "europe-southwest1"
}

variable "git_repo" {
  type = string
  default = "UriCW/inohealth-challenge"
  description = "A github repository"
}

variable "mock_endpoint" {
  type = string
  description = "A Mock endpoint for recieving the Biocomposition data from"
  default = "https://mockapi-furw4tenlq-ez.a.run.app/data"
}
