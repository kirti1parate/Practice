# Variable creation for VPC 
variable "cidr" {

    description = "Enter the range of CIDR block"
    type = string
    default = "192.168.0.0/16"
  
}

variable "vpc_name" {
    description = "Enter the Name of VPC"
    type = string
    default = "tcw_vpc"
  
}

#Variable declearation for name of IGW
variable "igw_tag" {
    description = "Enter the name for Internet Gateway"
    type = string
    default= "igw_vpc"

}

#Variable declaration for subnet1
variable "cidr_sub1" {
    description = "Enter the CIDR value for public_subnet_1"
    type = string
    default = "192.168.1.0/24"
  
}

        #declaration of name of public_subnet_1
        variable "subnet_name" {
            description = "Enter name of Public Subnet 1"
            type = string
            default = "Public Subnet_1"

        }

#Declaration of Variable for name of Route table
    variable "public_route" {
        description= "Enter name of Route table"
        type = string
        default = "Public_Route_table"
      
    }

#creation of EC2 Instance
            #Enter the AMI
                variable "amazon_ami" {
                    description = "Enter value for AMI"
                    type = string
                    default = "ami-0df435f331839b2d6"

                }

            #Select Instance type
                variable "instance_type1" {
                    description = "Enter instance type"
                    type = string
                    default = "t2.micro"                 
                }

            #Variable declaration for assign ppublic ip address
                variable "associate_public_ip_address" {
                    default = true
                    description = "assigning available public ip"
                    type = bool
                  
                }
            #Variable declaration for assigning default security group to EC2
                #variable "vpc_security_group_ids" {
                  #  description = "Select security groupid"
                   # default = aws_security_group.id
                  
               # }

            #Vaiable for key file
            variable "key_file" {
                description = "Provide kay pair file"
                type = string
                default= "Kirtikeypair"
                
              
            }
