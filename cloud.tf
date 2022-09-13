terraform {
  cloud {
    organization = "hashidemos"

    workspaces {
      tags = ["fancy-app"]
    }
  }
}
