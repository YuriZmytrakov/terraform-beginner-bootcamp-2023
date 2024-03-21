terraform {
  required_providers {
    terratowns ={
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "yurizmytrakov"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "yurizmytrakov"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
}
provider "terratowns" {
  # endpoint = "http://localhost:4567/api"
  endpoint = "https://terratowns.cloud/api"
  user_uuid="0009fb14-4512-458f-9ddb-fbdc0901619b" 
  token="c000feeb-0f77-4896-9e46-3e52eeb87890"
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   # error_html_filepath = var.error_html_filepath
#   error_html_filepath = "${path.root}/public/error.html"

#   # index_html_filepath = var.index_html_filepath
#   index_html_filepath = "${path.root}/public/index.html"

#   content_version = var.content_version
# }

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "missiongo"
  content_version = 1
}