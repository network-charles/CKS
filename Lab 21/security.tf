# Create a security group
resource "aws_security_group" "sg" {
  name        = "sg"
  vpc_id = aws_vpc.k8s.id
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg"
  }
}

# Create an IAM role for the EC2 instance to allow AWS SSM access.
resource "aws_iam_role" "EC2_Role" {
  name               = "EC2-Role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    "Name" = "EC2_Role"
  }
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2"
  role = aws_iam_role.EC2_Role.name

  tags = {
    "Name" = "ec2"
  }
}

resource "aws_iam_role_policy_attachment" "EC2_SSM" {
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
  role       = aws_iam_role.EC2_Role.name
}
