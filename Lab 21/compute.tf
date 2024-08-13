resource "aws_instance" "master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  subnet_id              = aws_subnet.my_subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 50
  }

  tags = {
    Name = "master"
  }
}

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  subnet_id              = aws_subnet.my_subnet_2.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 50
  }

  tags = {
    Name = "worker"
  }
}
