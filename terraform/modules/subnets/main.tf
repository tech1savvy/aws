resource "aws_subnet" "public_a" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.project_name}-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "${var.project_name}-public-b"
  }
}
