provider "aws" {
   region = "ap-south-1"
  }  
provider "tls"{} 

module "vpc" {
  source = "./network"
}
resource "aws_instance" "server" {
  count = 1
  ami = "ami-0108d6a82a783b352"
  key_name = "id_rsa"
  instance_type = "t2.micro"
  subnet_id = module.vpc.subnet_id.id
  security_groups = ["${module.vpc.id.id}"]
      
  tags = {
  Name = "server-1"
  }
}
resource "aws_key_pair" "kp" {
  key_name   = "id_rsa"       # Create "myKey" to AWS!!
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhlo2IcUJzauvVvuWU1tBxnXfFdN1zRO1DPTOwfdIPcvYfWnHVJVhYAnMaB83fP/aP0xqPxNEb4xK/OH235nB2UJZu8PkTprfL/iBwqjyElfAU9jtJ6pfFSMhWGtW7RbmupNeuwxu4Z6Y8l/xtXM5nJvQ6IZ5DKbdUq24VhpRza7rXxi3zrECaTze+ttuxagMf+jlaAfSc5X2fhAz8Hi3ZcQWX359r9vjD4oWNdVdjLRpvVlZqFK3EXLigCFWnOFBHR0R5kt3rZRUuoyYyTzMS7BwSwZMCDiouJvGKcZmkyshX0xpekjtJUgUNj5hFsONmGAsaTvLeH2ClvBRGPNpEOrYvdLgquKf6SPAI4dkWteZqUS0zsThhPHhh5I5KMsJrrZORcH/JkfbIVpweStmovtTQTQi54XVpOq1VOpqR7k14ysakFJ+81Bt0+kS9bnZ3WSjqYnisiTshkdUkykpDSCjeDXUPJYz1U7Hw5uLRV9zxxGAjJllef/S3R+TFU58= azuread/kasiyakkala@LAPTOP-UIIVRL8L"
}


