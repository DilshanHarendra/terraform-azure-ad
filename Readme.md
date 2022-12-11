###Steps
terraform init

terraform fmt

terraform validate

terraform plan

terraform apply


terraform destroy -target module.module_name


az ad sp list --display-name "Microsoft Graph" --query '[].{appDisplayName:appDisplayName, appId:appId}'

