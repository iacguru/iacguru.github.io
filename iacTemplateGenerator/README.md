## Description
This repo is code base for service enablement team cli tools.

## Self Service Stack Creator (S3C)
s3c is a cli tool to generate terraform templates/stack for given terraform modules.

## Usages
**Flags**
- repos: repos name seperated by commas. local directory, github repo name or combination of both.
- path: local path to create tf files.

Note :- depends_on block configured as per the sequence provided in repos flag. Other dependencies should be configured manually as per the requirements.

**Example**:
```
go run main.go -repos storagemodule,linuxvmmodule,terraform-azurerm-se-keyvault-cloud-3-0,terraform-azurerm-eca-windowsvm,terraform-azurerm-eca-mlservice -path s3c/test
```

## Prerequisites
Create following environment variables
- GH_TOKEN : Your Github PAT, required to download repos from github.
- ORG: Github Org name, required to download repos from github.