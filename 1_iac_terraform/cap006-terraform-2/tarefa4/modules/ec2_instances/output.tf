output "instance_ids" {
  value = aws_instance.bamr_instance.*.id
}