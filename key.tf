# Creating Keypar.pem File to my AWS_Instance
resource "aws_key_pair" "my_key_pair" {
    public_key = tls_private_key.rsa.public_key_openssh
    key_name = "access_key"
}
resource "local_file" "access_key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "access_key.pem"
    file_permission = "0400"
}
resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}
