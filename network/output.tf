output "subnet_id" {
    value = aws_subnet.my-subnet
}
output "privatesubnet_id" {
    value = aws_subnet.private
}
output "id" {
    value = aws_security_group.sg
}
output "priid" {
    value = aws_security_group.security_private
}
