output "master" {
  value = "aws ssm start-session --target ${data.aws_instance.master.id}"
}

output "master_public_ip" {
  value = "${data.aws_instance.master.public_ip}:80"
}

output "worker" {
  value = "aws ssm start-session --target ${data.aws_instance.worker.id}"
}

output "worker_public_ip" {
  value = "${data.aws_instance.worker.public_ip}:80"
}
