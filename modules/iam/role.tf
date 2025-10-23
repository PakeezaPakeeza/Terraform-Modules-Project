#That means this role is meant to be attached to EC2 instances — not users — so those EC2s can access AWS APIs (like S3, CloudWatch, etc.) without hardcoding access keys.
#ws_iam_role is just a stand-alone role (a “template”). It isn’t used by any EC2 until you:
	#1.	Give it permissions (attach policies),
	#2.	Wrap it in an instance profile, and
	#3.	Reference that instance profile in your EC2 resources.


resource "aws_iam_role" "ec2_role" {
  name = "${var.rolename}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Env = "${var.environment}"
  }
}
