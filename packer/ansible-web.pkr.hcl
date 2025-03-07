packer {
  required_plugins {
    # COMPLETE ME
    # add necessary plugins for ansible and aws
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.3"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.2"
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
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] 
	}
  ssh_username = "ubuntu"
  }

build {
  # COMPLETE ME
  # add configuration to: 
  # - use the source image specified above
  # - use the "ansible" provisioner to run the playbook in the ansible directory
  # - use the ssh user-name specified in the "variables.pkr.hcl" file
  name = "packer-4640-labweek9"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo usermod -aG sudo ubuntu",  # Add user to sudo group
      "echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ubuntu"  # Grant sudo without password prompt
    ]
  }
	
  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"
    user          = "ubuntu"
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
  }
}
