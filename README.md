## Prerequisites

### S3 bucket 
- dna-base-aws-setup

### SSH EC2 key
- dna-base-ssh-key

### IAM user with listed privileges
- AmazonEC2FullAccess
- AmazonS3FullAccess
- AmazonECS_FullAccess
- AmazonVPCFullAccess
- IAMReadOnlyAccess
- AmazonRoute53FullAccess 

Creation of all prerequisites can be also migrated to terraform, but due to lack of time I decide to create it manually.