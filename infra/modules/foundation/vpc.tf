resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "epcn-vpc"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "epcn-igw"
    }
}

resource "aws_subnet" "public" {
    count                   = 3
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
    map_public_ip_on_launch = true
    availability_zone       = element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "epcn-public-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count             = 3
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 3)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "epcn-private-${count.index + 1}"
    }
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "epcn-private-rt"
    }
}

resource "aws_route_table_association" "private" {
    count          = 3
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "epcn-public-rt"
    }
}

resource "aws_route" "public_internet_access" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
    count          = 3
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "alb" {
  name        = "epcn-alb-sg"
  description = "Allow HTTP/HTTPS inbound to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "epcn-alb-sg"
  }
}

resource "aws_security_group" "apps" {
  name        = "epcn-apps-sg"
  description = "Allow traffic from ALB to app containers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "App traffic from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "epcn-apps-sg"
  }
}

resource "aws_security_group" "ecs_services" {
    name        = "epcn-ecs-services-sg"
    description = "Allow ECS services communication"
    vpc_id      = aws_vpc.main.id

    ingress {
        description     = "Allow traffic from ALB SG"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.alb.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "epcn-ecs-services-sg"
    }
}