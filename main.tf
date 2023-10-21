
#create VPC
resource "aws_vpc" "myVPC" {

    cidr_block = var.cidr

    tags = {
      Name = var.vpc_name
    }
  
}

#Create Internet Gateway

resource "aws_internet_gateway" "myIGW"{
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.igw_tag
  }
  
}

#Creation of subnet
resource "aws_subnet" "Public_subnet_EC2_1"{
vpc_id = aws_vpc.myVPC.id
cidr_block = var.cidr_sub1
availability_zone = data.aws_availability_zones.available_1.names[0]

tags = {
  Name = var.subnet_name

}

}

#Creation of Route table
resource "aws_route_table" "Route_Public_Subnet" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = var.public_route

  }

}
              #Edit routes and Add route(Entry of Internet Gateway with all traffic)
                resource "aws_route" "Put_all_traffic" {
                route_table_id = aws_route_table.Route_Public_Subnet.id
                destination_cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.myIGW.id

  
                  }
                
              #Associate Subnet to route table
              resource "aws_route_table_association" "associate_table" {
                route_table_id = aws_route_table.Route_Public_Subnet.id
                subnet_id = aws_subnet.Public_subnet_EC2_1.id

          
              }


#Creation of EC2 Instance in VPC/Subnet
resource "aws_instance" "AmazonInstance" {
  key_name = var.key_file
  ami = var.amazon_ami
  instance_type = var.instance_type1
  subnet_id = aws_subnet.Public_subnet_EC2_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone = aws_subnet.Public_subnet_EC2_1.availability_zone 

tags = {
  Name = "Amazon_linux/MC"
}

}

#Set inbound rule to security group in intance
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.myVPC.id
  ingress = [{
                description = "Edit Inbound rule"
                from_port = 0 
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                ipv6_cidr_blocks = null
                prefix_list_ids  = null
                security_groups  = null
                self             = null
                } ,
                
                {
              description = "Allow SSH traffic"
              from_port = 22
              to_port = 22
              protocol = "TCP"
              cidr_blocks      = ["0.0.0.0/0"]
                ipv6_cidr_blocks = null
                prefix_list_ids  = null
                security_groups  = null
                self             = null

                }
                ] 

   

                tags = {
                  Name = "sg_vpc"
                }
  
}


  
