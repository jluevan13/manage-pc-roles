terraform {
  required_providers {

    prismacloud = {
      source = "paloaltonetworks/prismacloud"
    }
  }
}

provider "prismacloud" {
  json_config_file = "/Users/user-name/prismacloud_auth.json"
}
