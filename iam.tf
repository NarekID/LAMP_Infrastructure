data "aws_iam_policy" "rds_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role" "rds_full_access" {
  name = "RDS-FullAccess"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "rds_full_access" {
  name = "RDS-FullAccess"
  role = aws_iam_role.rds_full_access.name
}

resource "aws_iam_role_policy_attachment" "rds_full_access" {
  role       = aws_iam_role.rds_full_access.name
  policy_arn = data.aws_iam_policy.rds_full_access.arn
}