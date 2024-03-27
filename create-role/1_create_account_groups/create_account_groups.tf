# get all cloud accounts from Prisma cloud
data "prismacloud_cloud_accounts" "example" {}

# create an account group for each cloud account
# Account Group name is derived from the cloud account name
# Account ID is the unique cloud account id
resource "prismacloud_account_group" "example" {
  for_each    = { for index, account in data.prismacloud_cloud_accounts.example.listing : account.account_id => account }
  name        = "${each.value.name} - Account Group"
  description = "Made by Terraform"
  account_ids = [each.value.account_id]
}

# this is commented out. it is used to view the raw data of how cloud accounts are fetched
# output "cloud_accounts" {
#     value = data.prismacloud_cloud_accounts.example.listing
# }
