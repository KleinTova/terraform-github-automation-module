output "members" {
  value = local.members
}

output "teams-per-permission" {
  value = github_team.teams-per-permission
}

output "parent-team-for-group" {
  value = github_team.parent-team-for-group
}