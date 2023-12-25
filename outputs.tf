output "get_instance_name" {
    value = aws_instance.my_instance.tags.Name
}
output "get_public_ip"{
    value = aws_instance.my_instance.public_ip
}
