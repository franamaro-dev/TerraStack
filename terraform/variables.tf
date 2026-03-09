variable "aws_region" {
  description = "The AWS region to deploy the FinTech infrastructure in."
  # e.g., eu-south-2 (Spain) ensures Data Sovereignty for TicketBAI/VeriFactu
  default     = "eu-south-2"
}

variable "admin_ip_cidr" {
  description = "The precise CIDR block of the Administrator's IP to allow SSH access."
  type        = string
  # IMPORTANT: In a real environment, override this via TF_VAR_admin_ip_cidr
  default     = "0.0.0.0/0"
}
