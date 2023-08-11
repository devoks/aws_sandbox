## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 5.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.12.0  |

## Modules

| Name                                         | Source        | Version |
| -------------------------------------------- | ------------- | ------- |
| <a name="module_vpc"></a> [vpc](#module_vpc) | ./modules/vpc | n/a     |

## Resources

| Name                                                                                                                                                                                     | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                                                         | resource |
| [aws_s3_bucket.doka_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                              | resource |
| [aws_s3_bucket_public_access_block.public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                             | resource |
| [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource |

## Inputs

| Name                                                      | Description | Type                                                                                                                                                                                                                                                                      | Default | Required |
| --------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_networks"></a> [networks](#input_networks) | n/a         | <pre>map(object({<br> cidr_block = string<br> instance_tenancy = string<br> enable_dns_support = bool<br> enable_dns_hostnames = bool<br> subnets = map(object({<br> cidr_block = string<br> availability_zone_id = string<br> subnet_name = string<br> }))<br> }))</pre> | n/a     |   yes    |

## Outputs

| Name                                                                                         | Description                    |
| -------------------------------------------------------------------------------------------- | ------------------------------ |
| <a name="output_dynamodb_table_name"></a> [dynamodb_table_name](#output_dynamodb_table_name) | The name of the DynamoDB table |
| <a name="output_s3_bucket_arn"></a> [s3_bucket_arn](#output_s3_bucket_arn)                   | The ARN of the S3 bucket       |
