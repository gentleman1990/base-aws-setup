## Implementation

All terraform results of this repository can be checked via http://dna.cloverland.pl
Simple service comes from yeasy/simple-web has been deployed and can be publicly accessible 

## Prerequisites

### S3 bucket 
- dna-base-aws-setup

### SSH EC2 key
- dna-base-ssh-key

### IAM user with listed privileges (used for perform terraform)
- AmazonEC2FullAccess
- AmazonS3FullAccess
- AmazonECS_FullAccess
- AmazonVPCFullAccess
- IAMReadOnlyAccess
- AmazonRoute53FullAccess 
- CloudFrontFullAccess

### IAM role for ECS (the scope of the privileges need to be cut down!)
- AmazonEC2FullAccess
- AmazonECS_FullAccess

Creation of all prerequisites can be also migrated to terraform, but due to lack of time I decide to create it manually.


## Thoughts

- I am almost sure that not all the code developed here follow best practices. It is my first time when I need to expose smth to the public internet :)
- In the latest version I would split creation of infra (like VPC, SG) from creation of ECS
- Creation of bucket for terraform states via terraform can be tricky. It should be moved to terraform, but it still can require manual action - copy and paste local tfstate to bucket after creation it locally.
- IAM User has been created manually to perform terraform, however in production environment ldap/AzureAD is being used. If service user is need my recommendation would be to use Vault.
- IAM role for ECS should be also created via terraform + the scope of the privileges should be cut down
- Security groups created within a module has been modified via AWS console to open 80 and 22 port to the world
