# Creating AWS_Instance 
resource "aws_instance" "my_instance" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.medium"
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    tags = {Name = "Continuous Delivery"}
    key_name = "access_key"

    # Allocating Storage 
    root_block_device {
        volume_size = 30
    }

    # Logging into the Server
    connection {
        type = "ssh"
        user = "ubuntu"
        host = aws_instance.my_instance.public_ip
        private_key = tls_private_key.rsa.private_key_pem
    }

    # Executing the Packages file
    provisioner "remote-exec" {
        inline = [
            "git clone https://github.com/Ravitejadarla5/shall-scripts.git",
        ]
    }
}