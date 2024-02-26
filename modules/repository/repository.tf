terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.29.0"
    }
  }
}

resource "github_repository" "github-repo" {
  name                   = var.repo.name
  description            = var.repo.description
  visibility             = var.repo.visibility
  auto_init              = var.repo.auto_init
  topics                 = var.topics
  has_issues             = var.repo.issues
  has_projects           = var.repo.projects
  allow_auto_merge       = var.repo.auto_merge
  delete_branch_on_merge = var.repo.auto_delete_branch
}

resource "github_branch_protection" "branch_protection" {
  depends_on = [
    github_repository.github-repo
  ]
  repository_id    = var.repo.name
  pattern          = var.branch
  enforce_admins   = var.enforce_admins
  allows_deletions = true
  require_conversation_resolution = true

  required_status_checks {
    strict   = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    require_code_owner_reviews = var.code_owner_reviews
  }
}

resource "github_team_repository" "team_repo" {
  depends_on = [
    github_repository.github-repo
  ]
  repository = var.repo.name 
  for_each = var.teams
  team_id    = each.key
  permission = each.value
}

resource "github_team_repository" "teams_repo" {
   depends_on = [
       github_repository.github-repo,
  ]
  repository = var.repo.name
  for_each = var.teams-permissions
  team_id = "${var.group_name}-${each.key}"
  permission = each.value
}




resource "github_repository_collaborator" "a_repo_collaborator" {
  depends_on = [
    github_repository.github-repo
  ]
  repository = var.repo.name 
  for_each = var.collaborators
  username   = each.key
  permission = each.value
}

resource "github_repository_file" "files" {
  depends_on = [
    github_repository.github-repo
  ]
  repository          = var.repo.name 
  for_each            = {for file in var.files : file.path =>file}
  branch              = var.branch
  file                = each.value.path
  content             = each.value.content
  commit_message      = "initialized"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      commit_author, 
      commit_email,
      commit_message,
      content
    ]
  }
}

resource "github_actions_secret" "secrets" {
  depends_on = [
    github_repository.github-repo
  ]
  repository      = var.repo.name 
  for_each        = var.secrets
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_repository_file" "codeowners" {
  depends_on = [
    github_repository.github-repo
  ]
  repository          = var.repo.name 
  branch              = var.branch
  file                = ".github/CODEOWNERS"
  content             = "* @KleinTova/${var.group_name}-maintain"
  commit_message      = "CODEOWNERS"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      commit_author, 
      commit_email,
      commit_message
    ]
  }
}