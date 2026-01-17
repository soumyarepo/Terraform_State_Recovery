# Terraform_State_Recovery
If a Terraform state file is deleted, the recovery approach depends on where the state was stored. In production, Terraform state is almost always stored remotely with versioning enabled, so restoration is usually straightforward.


What We Will Build

Terraform-managed EC2 instance

Remote backend (S3 + DynamoDB)

Enable state versioning

Simulate accidental state deletion

Restore state safely
===============================================================================
STEP 1: Create AWS Resources for Terraform Backend
1️⃣ Create S3 Bucket (Enable Versioning)

aws s3api create-bucket \
  --bucket terraform-state-recovery-demo \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1


Enable versioning:

aws s3api put-bucket-versioning \
  --bucket terraform-state-recovery-demo \
  --versioning-configuration Status=Enabled

2️⃣ Create DynamoDB Table for State Locking

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

STEP 2: Terraform Project Structure
terraform-state-recovery/
│── main.tf
│── backend.tf
│── provider.tf
