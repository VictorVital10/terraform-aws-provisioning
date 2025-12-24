output "instance_public_ip" {
  value = aws_instance.nginx-server.public_ip
}

output "instance_state" {
  value = aws_instance.nginx-server.instance_state
}
