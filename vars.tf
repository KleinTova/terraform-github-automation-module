terraform {
  experiments = [module_variable_optional_attrs]
} 

variable "github_owner" {
  type = string
  default = ""
}

variable "github_token" {
  type = string
  default = ""
}

variable "repo" {
 type = object({
   name = string
   description = optional(string)
   visibility = optional(string)
   auto_init = optional(bool)
   issues = optional(bool)
   projects = optional(bool)
   auto_delete_branch = optional(bool)
   auto_merge = optional(bool)

 })
 default = {
   name = "test_module_repo"
   description = "github module that creates auomotacilly from terraform module"
   auto_init = true
   visibility = "public"
   issues = true
   projects = true
   auto_delete_branch = true
   auto_merge = true
 }
}

variable "branch" {
  default     = "main"
  description = "git branch name"
}

variable "secrets" {
  type = map
  default = {
  }
  description = "Map of repository secrets"
}

variable "teams" {
  type = map
  description = "teams names"
  default = {}
}

variable "collaborators" {
  type = map
  description = "Map of repository Collaborators"
  default = {}
}

variable "enforce_admins" {
  type    = bool
  default = false
  description = "Branch protection enforce_admins (true/false)"
}

variable "topics" {
  type    = list(string)
  default = []
}

variable "group_name" {
  type = string
  default = "test"
}

variable "code_owner_reviews" {
  type = bool
  default = true
}

variable "team_members" {
  type = list(object({
    team = string
    members = list(object({
      username = string
      role = string
    }))
  }))
  default = [
    {
      team = "admin",
      members = [
        {
          username = "KleinTova"
          role = "maintainer"
        }
      ]
    }
  ]
}