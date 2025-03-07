# Lab Week 9

## Prerequisites
- AWS account with CLI configured
- SSH key pair imported using `import_lab_key` script

## Instructions

1. **Import SSH Key**:
   ```bash
   ./import_lab_key

2. **Build AMI with Packer**:
   ```bash
   cd packer
   packer init .
   packer validate
   packer build .

3. **Deploy EC2 Instance with Terraform**:
   ```bash
   cd ../terraform
   terraform init
   terraform validate
   terraform apply
