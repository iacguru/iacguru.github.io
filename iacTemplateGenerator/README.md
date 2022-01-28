## Terraform Generator
Generate terraform templates/stack for given terraform modules.

## Usages
**Flags**
- repos: repos name seperated by commas. local directory, github repo name or combination of both.
- path: local path to create tf files.

Note :- depends_on block configured as per the sequence provided in repos flag. Other dependencies should be configured manually as per the requirements.

**Example**:
```
go run main.go -repos <comma seperated repo names> -path <path where tf code will be generated>
```

## Prerequisites
Create following environment variables
- GH_TOKEN : Your Github PAT, required to download repos from github.
- ORG: Github Org name, required to download repos from github.