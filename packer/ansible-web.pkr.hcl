packer {
  required_plugins {
    # COMPLETE ME
    # add necessary plugins for ansible and aws
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  # COMPLETE ME
  # add configuration to use Ubuntu 24.04 image as source image
  region        = "us-west-2"
  instance_type = "t2.micro"
  ami_name      = "packer-ansible-nginx"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] # Canonical (official Ubuntu AMIs)
    most_recent = true
  }

  ssh_username = var.ssh_username
}

build {
  # COMPLETE ME
  # add configuration to: 
  # - use the source image specified above
  # - use the "ansible" provisioner to run the playbook in the ansible directory
  # - use the ssh user-name specified in the "variables.pkr.hcl" file
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"

    user = var.ssh_username

    environment_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
  }
}
