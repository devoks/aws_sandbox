# data "aws_caller_identity" "second" {
#   provider = aws.secondaccount
# }

# output "second_account_id" {
#   value = data.aws_caller_identity.second.account_id
# }

# data "aws_caller_identity" "third" {
#   provider = aws.thirdaccount
# }

# output "third_account_id" {
#   value = data.aws_caller_identity.third.account_id
# }
