repo = {
   name = "test_module_repo"
   description = "github module that creates auomotacilly from terraform module"
   auto_init = true
   visibility = "public"
   issues = true
   projects = true
   auto_delete_branch = true
   auto_merge = true
 }
branch = "main"

secrets = {}

teams = {}

collaborators = {}

enforce_admins = false

topics = []

group_name = "test"

code_owner_reviews = true

team_members = [
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