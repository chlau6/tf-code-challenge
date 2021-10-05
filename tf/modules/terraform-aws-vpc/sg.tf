resource "aws_security_group" "default" {
  name    = "${var.project}-default-sg"
  vpc_id  = aws_vpc.vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "${var.project}-sg"
  }
}