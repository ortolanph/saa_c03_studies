data "aws_iam_policy_document" "s3_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "s3_replication_role" {
  name               = "source-replication-role"
  assume_role_policy = data.aws_iam_policy_document.s3_assume_role.json
}

data "aws_iam_policy_document" "s3_replication_document" {
  statement {
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetReplicationConfiguration",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectRetention",
      "s3:GetObjectLegalHold"
    ]
    resources = [
      aws_s3_bucket.s3_source_certificate_bucket.arn,
      "${aws_s3_bucket.s3_source_certificate_bucket.arn}/*",
      aws_s3_bucket.s3_target_certificate_bucket.arn,
      "${aws_s3_bucket.s3_target_certificate_bucket.arn}/*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    resources = [
      "${aws_s3_bucket.s3_source_certificate_bucket.arn}/*",
      "${aws_s3_bucket.s3_target_certificate_bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "s3_replication_policy" {
  name   = "source-replication-policy"
  policy = data.aws_iam_policy_document.s3_replication_document.json
}

resource "aws_iam_role_policy_attachment" "s3_replication_attachment" {
  role       = aws_iam_role.s3_replication_role.name
  policy_arn = aws_iam_policy.s3_replication_policy.arn
}
