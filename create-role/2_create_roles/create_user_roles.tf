locals {
  repo_list = [
    {
      "reed-csp-accounts - Role" : ["9649d6f2-b89c-4533-ad18-612d84c2620f"],
      "JT Account Group - Role" : ["9e0142eb-8904-487c-8969-30558b0daa43", "9649d6f2-b89c-4533-ad18-612d84c2620f"]
    }
  ]
}

# fetch all account groups from Prisma cloud
data "prismacloud_account_groups" "example" {}

# create a role for each account group
resource "prismacloud_user_role" "example" {
  for_each = { for index, group in data.prismacloud_account_groups.example.listing : group.group_id => group }
  # name     = "${each.value.name} - Role"
  # name                = "${trimsuffix(each.value.name, ' - ')} - Role"
  name                = "${split(" - ", each.value.name)[0]} - Role"
  description         = "Made by Terraform"
  role_type           = "Account Group Admin" # permission group name
  account_group_ids   = [each.value.group_id]
  code_repository_ids = lookup(local.repo_list[0], "${each.value.name} - Role", [])
}

# this is commented out. it is used to view the raw data of how account groups are fetched
# output "groups" {
#     value = data.prismacloud_account_groups.example.listing
# }
