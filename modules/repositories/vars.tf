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
   if_exists = optional(bool)
   issues = optional(bool)
   projects = optional(bool)
   auto_delete_branch = optional(bool)
   auto_merge = optional(bool)

 })
 default = {
   auto_init = true
   description = ""
   name = ""
   visibility = "internal"
   if_exists = false
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
  default = {}
  description = "Map of repository secrets"
}

variable "files" {
  type = list(object({
    path = string
    content = any
  }))
  default = []
  description = "initial files"
}

variable "teams" {
  type = map
  description = "teams names"
}

variable "collaborators" {
  type = map
  description = "Map of repository Collaborators"
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

variable "group_name" {
  type = string
}

variable "code_owner_reviews" {
  type = bool
  default = true
}

variable "teams-id" {
  type = map
  default = {}
}

variable "test_branch" {
  type = string
  default = ""
}