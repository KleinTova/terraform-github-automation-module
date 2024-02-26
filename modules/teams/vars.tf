variable "github_owner" {
  type = string
  default = ""
}

variable "github_token" {
  type = string
  default = ""
}

variable "group_name" {
  type = string
  description = "group name to create the teams"
}

variable "teams-permissions" {
  type = map(string)
  default = {
    read = "pull"
    triage = "triage"
    write = "push"
    maintain = "maintain"
    admin = "admin"
  }
}

variable "team_members" {
  type = list(object({
    team = string
    members = list(object({
      username = string
      role = string
    }))
  }))
}