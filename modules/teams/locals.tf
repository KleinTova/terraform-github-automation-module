  locals {
    members = flatten([
        for teams in  toset(var.team_members) :  [
            for members in teams.members : {
                team = teams.team
                username = members.username
                role = members.role
            }
        ]
    ])
}

