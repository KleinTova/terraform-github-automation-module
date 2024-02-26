terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.29.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
  alias = "github"
}

module "repository" {
  providers = {
    github = github.github
  }
  depends_on = [ module.teams ]
  source = "./modules/repository"
  github_token = var.github_token
  repo = {
    name               = var.repo.name
    description        = var.repo.description
    visibility         = var.repo.visibility
    auto_init          = var.repo.auto_init
    issues             = var.repo.issues
    projects           = var.repo.projects
    auto_delete_branch = var.repo.auto_delete_branch
    auto_merge         = var.repo.auto_merge
  }
  branch = var.branch
  secrets = var.secrets    
  teams = var.teams
  collaborators = var.collaborators
  enforce_admins = var.enforce_admins
  topics = var.topics
  group_name = var.group_name
  code_owner_reviews = var.code_owner_reviews
}

module "teams" {
  providers = {
    github = github.github
  }
  source = "./modules/teams"
  github_token = var.github_token
  github_owner = var.github_owner
  team_members = var.team_members
  group_name = var.group_name
}