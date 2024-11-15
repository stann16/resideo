variable "ami_id" {
  description = "AMI ID for EC2 instances"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "user_data" {
  description = "User data script to set up Tomcat"
}

variable "instance_security_group" {
  description = "Security group for the instances"
}

variable "lb_security_group" {
  description = "Security group for the Load Balancer"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ASG"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "min_size" {
  default     = 1
  description = "Minimum size of the ASG"
}

variable "max_size" {
  default     = 3
  description = "Maximum size of the ASG"
}

variable "desired_capacity" {
  default     = 2
  description = "Desired capacity of the ASG"
}

