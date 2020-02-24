terraform {

  source = "../../../../modules//linux-bastion"

}

dependencies {
  paths = ["../network"]
}

include {
  path = find_in_parent_folders()
}
