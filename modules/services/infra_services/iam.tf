#Create a policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy

resource "aws_iam_policy" "ec2_s3_policy" {
 name = "${var.cloud_env}_ec2_s3_policy"
 path = "/"
 description = "policy to provide permission to S3"
 policy = jsonencode ({
  Version = "2012-10-17"
  Statement = [
    {
	 Action = [
	   "s3:GetObject",
	   "s3:PutObject",
	   "s3:ListBucket"
	 ]
	 Effect = "Allow"
	 Resource = [
	   "arn:aws:s3:::sdlc-${var.bucket_name}",
	   "arn:aws:s3:::sdlc-${var.bucket_name}/*"
	 ]
	}
   ]
 })
}

#Create a Role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "ec2_s3_access_role" {
 name = "${var.cloud_env}-ec2-s3-role"
 assume_role_policy = "${file("${path.module}/assumerolepolicy.json")}"
}

#Attach role to policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "ec2_s3_policy_role" {
 # name = "${var.cloud_env}_ec2_s3_attachment"
 role = aws_iam_role.ec2_s3_access_role.name
 policy_arn = aws_iam_policy.ec2_s3_policy.arn
 
 lifecycle {
  create_before_destroy = true
 }
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile

resource "aws_iam_instance_profile" "ec2_s3_profile" {
 name = "${var.cloud_env}-ec2-s3-role"
 role = aws_iam_role.ec2_s3_access_role.name
}