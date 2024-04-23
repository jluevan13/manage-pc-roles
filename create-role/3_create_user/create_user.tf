locals {
  user_list = [
    {
      "email" : "tf_user@email.com",
      "first_name" : "TF First Name",
      "last_name" : "TF Last Name",
      "username" : "tf_user@email.com",
      "role_ids" : ["763ef426-4460-4611-bd58-f4b0480e6891", "3f873519-f595-4e7e-a813-6bbb4e7d9cc9"],
      "default_role_id" : "763ef426-4460-4611-bd58-f4b0480e6891"
    },
    {
      "email" : "tf_user2@email.com",
      "first_name" : "TF First Name2",
      "last_name" : "TF Last Name2",
      "username" : "tf_user2@email.com",
      "role_ids" : ["763ef426-4460-4611-bd58-f4b0480e6891"],
      "default_role_id" : "763ef426-4460-4611-bd58-f4b0480e6891"
    }
  ]
}

# fetch all roles from Prisma cloud to get the role id
data "prismacloud_user_roles" "example" {}

resource "prismacloud_user_profile" "example" {
  for_each   = { for index, user in local.user_list : user.email => user }
  first_name = each.value.first_name
  last_name  = each.value.last_name
  email      = each.value.email
  username   = each.value.username
  role_ids   = each.value.role_ids
  time_zone  = "America/Los_Angeles"
  # default_role_id     = each.value.default_role_id        # explicitly define a default role id
  default_role_id     = each.value.role_ids[0] # use the first role id in the role ids list as the default role
  access_keys_allowed = true
}

## this is commented out. it is used to view the raw data of how roles are fetched
output "groups" {
  value = data.prismacloud_user_roles.example.listing
}
