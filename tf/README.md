This module is to achieve level 3 in code challenge

I have imagined some use case on level 3:

1. when user create the custom subnet, they want to attach to the existing internet gateway / nat gateway, so we don't need to attach to the newly create internet gateway / nat gateway.
2. assume custom subnets have already attached to the existing internet gateway and nat gateway, user want to segregate and attach to the newly create internet gateway / nat gateway

Configuration:
1. For best practice, I should choose S3 as the tfstate storage, but I locally store the tfstate for the sake of simplicity
2. I use `aws configure` to set my security credential. When using `terraform apply`, terraform will load my security credential to pass the authentication. 2FA and assume role may be needed for security concern but I don't use it for the sake of simplicity

My testing command:
1. `terraform apply --auto-approve -target module.test1`
2. `terraform apply --auto-approve -target module.test2`
