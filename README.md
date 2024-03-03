# SAA_C03 Studies

Studies from the book **AWS Certified Solutions Architect - Sutdy Guide**.

## Chapters

### Chapter 2 - Compute Service

* [EC2](ec2/README.md)
* [EC2 LAUNCH TEMPLATE](ec2_launch_template/README.md)

## Chapter 3 - AWS Storage

* [S3 Buckets](s3/README.md)

## Chapter 4 - Amazon Virtual Private Cloud (VPC)

* [VPC](vpc/README.md)

## Chapter 5 - Database Services

* Database Services

## Running the examples

To run the examples you should first make some configurations on AWS and on the configuration files on the local
computer.

### AWS

On **IAM** create an user. It'll give credentials: an access key and a secret access key.

On **IAM** create a **Terraform** Role and use the policy **AdministratorAccess**. That will give you permission to
build every kind of resource that you are allowed to.

### Local Computer

Modify the configuration files:

`config`

```toml
[default]
region = eu-west-1
output = json

[saa_c03_studies]
role_arn=arn:aws:iam::123456789012:role/your_terraform_role
source_profile=saa_c03_studies
```

`credentials`

```toml
[saa_c03_studies]
aws_access_key_id = MYAWESOME_CREDENTIAL
aws_secret_access_key = MY_AWESOME_SECRET_ACCESS_KEY_XXXXXXXXXXX
```

## Checkov Tests

**Simple**
```shell
checkov --quiet -s -d .
```

**With JUnit Output**
```shell
checkov --quiet -s -o junitxml -d .
```

**With Github Failed Only Output**
```shell
checkov --quiet -s -o github_failed_only -d .
```