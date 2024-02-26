terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.29.0"
    }
  }
}

resource "github_team" "parent-team-for-group" {
  name        = "${var.group_name}-parent"
  description = "This team includes all the teams of group ${var.group_name} and does not include direct members"
  privacy     = "closed"
  create_default_maintainer = true
}

resource "github_team" "teams-per-permission" {
  for_each       = var.teams-permissions
  name           = "${var.group_name}-${each.key}"
  description    = "${each.key} team for group ${var.group_name}"
  parent_team_id = github_team.parent-team-for-group.id
  privacy        = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "members" {
  for_each = {
    for member in local.members :
    member.username => member
  }
  username = each.value.username
  role     = each.value.role
  team_id  = github_team.teams-per-permission[each.value.team].id
}