resource "aws_instance" "app" {
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
 
  subnet_id = aws_subnet.public.id
 
  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]
 
  tags = {
    Name = "abc-ec2"
  }
}
