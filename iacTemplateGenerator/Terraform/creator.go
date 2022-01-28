package s3c

import (
	"fmt"
	"os"
	"strings"

	"github.com/hashicorp/hcl/v2"
	"github.com/hashicorp/hcl/v2/hclwrite"
	"github.com/hashicorp/terraform-config-inspect/tfconfig"
	"github.com/zclconf/go-cty/cty"
)

var (
	uniq = map[string]string{
		"client_id":       "",
		"tenant_id":       "",
		"subscription_id": "",
		"client_secret":   "",
	}
	providers     = []string{}
	resourceTypes = []string{}

	valueReplacement = map[string]string{
		"string":     "\"\"",
		"list(\"\")": "[]",
		"number":     "0",
		"bool":       "false",
	}
)

type Creator struct {
}

// Template creator from terraform module
func (c *Creator) CreateModuleBlock(resources []string) *hclwrite.File {
	var version string
	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	for _, resource := range resources {
		fmt.Printf("Creating '%v' module block.....\n", resource)
		module, _ := tfconfig.LoadModule(resource)
		source := c.SourceGenerator(resource)
		if contains(gitRepos, resource) {
			version = tags(os.Getenv("GH_TOKEN"), os.Getenv("ORG"), resource)[0]
		}
		newTerraformFileBody.AppendNewline()
		newTerraformFileBody.AppendUnstructuredTokens(hclwrite.TokensForTraversal(hcl.Traversal{
			hcl.TraverseRoot{
				Name: CommentGenerator("module", resource),
			},
		}))
		newTerraformFileBody.AppendNewline()

		moduleBlock := newTerraformFileBody.AppendNewBlock("module", []string{resource})
		moduleBody := moduleBlock.Body()
		var mproviders string
		for _, p := range module.RequiredProviders {
			if p.ConfigurationAliases != nil {
				for _, v1 := range p.ConfigurationAliases {
					fmt.Printf("creating provider attributes in module '%v' block for '%v'.....\n", resource, v1.Name+"."+v1.Alias)
					mproviders = mproviders + "\t" + v1.Name + "." + v1.Alias + " = " + v1.Name + "." + v1.Alias + "\n\t"
				}
				moduleBody.SetAttributeTraversal("providers", hcl.Traversal{
					hcl.TraverseRoot{
						Name: "{" + "\n\t" + mproviders + "  }",
					},
				})
			}
		}
		moduleBody.SetAttributeValue("source", cty.StringVal(source))
		moduleBody.SetAttributeValue("version", cty.StringVal(version))
		if len(resources) > 1 && resources[0] != resource {
			fmt.Printf("creating depends_on block for '%v'.....\n", resource)
			moduleBody.SetAttributeTraversal("depends_on", hcl.Traversal{
				hcl.TraverseRoot{
					Name: c.DependsOnGenerator(resource, resources),
				},
			})
		} else {
			moduleBody.SetAttributeValue("depends_on", cty.ListValEmpty(cty.String))
		}
		for _, v := range module.Variables {
			moduleBody.SetAttributeTraversal(v.Name, hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var." + v.Name,
				},
			})
		}
	}
	return newTerraformFile
}

func (c *Creator) CreateVariableBlocks(resources []string) *hclwrite.File {
	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	for _, resource := range resources {
		newTerraformFileBody.AppendNewline()
		newTerraformFileBody.AppendUnstructuredTokens(hclwrite.TokensForTraversal(hcl.Traversal{
			hcl.TraverseRoot{
				Name: CommentGenerator("variables", resource),
			},
		}))
		newTerraformFileBody.AppendNewline()
		module, _ := tfconfig.LoadModule(resource)
		for _, v := range module.Variables {
			if _, ok := uniq[v.Name]; !ok {
				variableBlock := newTerraformFileBody.AppendNewBlock("variable", []string{"" + v.Name})
				variableBody := variableBlock.Body()
				variableBody.SetAttributeValue("description", cty.StringVal(v.Description))
				if v.Type != "" {
					variableBody.SetAttributeTraversal("type", hcl.Traversal{
						hcl.TraverseRoot{
							Name: v.Type,
						},
					})
				}
				uniq[v.Name] = v.Description
			}

		}

	}
	return newTerraformFile
}

func (c *Creator) CreateTerraformBlock(resources []string) *hclwrite.File {
	for _, resource := range resources {
		module, _ := tfconfig.LoadModule(resource)
		for _, resource := range module.ManagedResources {
			providers = append(providers, resource.Provider.Name)
		}
	}
	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	terraformBlock := newTerraformFileBody.AppendNewBlock("terraform", []string{})
	terraformBody := terraformBlock.Body()
	terraformBody.SetAttributeValue("required_version", cty.StringVal(">= 1.0"))
	terraformSubBlock := terraformBody.AppendNewBlock("required_providers", []string{})
	terraformSubBlockBody := terraformSubBlock.Body()
	for _, provider := range unique(providers) {
		switch provider {
		case "azurerm":
			terraformSubBlockBody.SetAttributeValue("azurerm", cty.ObjectVal(map[string]cty.Value{
				"source":  cty.StringVal("hashicorp/azurerm"),
				"version": cty.StringVal("~> 2.20"),
			}))

		case "sdm":
			terraformSubBlockBody.SetAttributeValue("sdm", cty.ObjectVal(map[string]cty.Value{
				"source":  cty.StringVal("strongdm/sdm"),
				"version": cty.StringVal("~> 1.0.27"),
			}))

		case "vault":
			terraformSubBlockBody.SetAttributeValue("vault", cty.ObjectVal(map[string]cty.Value{
				"source":  cty.StringVal("hashicorp/vault"),
				"version": cty.StringVal("~> 2.8"),
			}))

		}
	}

	return newTerraformFile
}

func (c *Creator) CreateProviderBlock(resources []string) *hclwrite.File {
	for _, resource := range resources {
		module, _ := tfconfig.LoadModule(resource)
		for _, resource := range module.ManagedResources {
			providers = append(providers, resource.Provider.Name)
			resourceTypes = append(resourceTypes, resource.Type)
		}
	}

	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	if contains(resourceTypes, "azurerm_linux_virtual_machine") || contains(resourceTypes, "azurerm_windows_virtual_machine") {
		providerBlock1 := newTerraformFileBody.AppendNewBlock("provider", []string{"azurerm"})
		providerBody1 := providerBlock1.Body()
		providerBody1.SetAttributeValue("alias", cty.StringVal("image"))
		providerBody1.SetAttributeTraversal("subscription_id", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.image_subscription",
			},
		})
		providerBody1.SetAttributeTraversal("tenant_id", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.tenant_id",
			},
		})
		providerBody1.SetAttributeTraversal("client_id", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.client_id",
			},
		})
		providerBody1.SetAttributeTraversal("client_secret", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.client_secret",
			},
		})
		providerBody1.AppendNewBlock("features ", []string{})

		providerBlock2 := newTerraformFileBody.AppendNewBlock("provider", []string{"azurerm"})
		providerBody2 := providerBlock2.Body()
		providerBody2.SetAttributeValue("alias", cty.StringVal("law"))
		providerBody2.SetAttributeValue("subscription_id ", cty.StringVal(""))
		providerBody2.SetAttributeTraversal("tenant_id", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.tenant_id",
			},
		})
		providerBody2.SetAttributeTraversal("client_id", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.client_id",
			},
		})
		providerBody2.SetAttributeTraversal("client_secret", hcl.Traversal{
			hcl.TraverseRoot{
				Name: "var.client_secret",
			},
		})
		providerBody2.AppendNewBlock("features ", []string{})
	}
	for _, k := range unique(providers) {
		if k == "azurerm" {
			fmt.Printf("creating '%v' provider block.....\n", k)
			providerBlock3 := newTerraformFileBody.AppendNewBlock("provider", []string{k})
			providerBody3 := providerBlock3.Body()
			providerBody3.SetAttributeTraversal("subscription_id", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.subscription_id",
				},
			})
			providerBody3.SetAttributeTraversal("tenant_id", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.tenant_id",
				},
			})
			providerBody3.SetAttributeTraversal("client_id", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.client_id",
				},
			})
			providerBody3.SetAttributeTraversal("client_secret", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.client_secret",
				},
			})
			providerBody3.AppendNewBlock("features ", []string{})

		}
		if k == "sdm" {
			fmt.Printf("creating '%v' provider block.....\n", k)
			newTerraformFileBody.AppendNewBlock("provider", []string{k})
		}
		if k == "vault" {
			fmt.Printf("creating '%v' provider block.....\n", k)
			providerBlock := newTerraformFileBody.AppendNewBlock("provider", []string{k})
			providermBody := providerBlock.Body()
			providermBody.SetAttributeTraversal("address ", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.vault_url",
				},
			})
			providermBody.SetAttributeTraversal("token ", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "var.vault_token",
				},
			})
			providermBody.SetAttributeValue("skip_tls_verify", cty.True)
		}
		if k == "mongodbatlas" {
			fmt.Printf("creating '%v' provider block.....\n", k)
			providerBlock := newTerraformFileBody.AppendNewBlock("provider", []string{k})
			providermBody := providerBlock.Body()
			providermBody.SetAttributeValue("public_key", cty.StringVal(""))
			providermBody.SetAttributeValue("private_key", cty.StringVal(""))
		}

	}
	return newTerraformFile
}

func (c *Creator) CreateProviderVariableBlocks(resources []string) *hclwrite.File {
	for _, resource := range resources {
		module, _ := tfconfig.LoadModule(resource)
		for _, resource := range module.ManagedResources {
			providers = append(providers, resource.Provider.Name)
		}
	}
	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	for _, k := range unique(providers) {
		if k == "azurerm" {
			fmt.Printf("creating '%v' provider variables.....\n", k)
			providerVariableBlock1 := newTerraformFileBody.AppendNewBlock("variable", []string{"subscription_id"})
			providerVariableBody1 := providerVariableBlock1.Body()
			providerVariableBody1.SetAttributeValue("description", cty.StringVal("The subscription_id of a service principal in the owner role for the subscription"))
			providerVariableBody1.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
			providerVariableBlock2 := newTerraformFileBody.AppendNewBlock("variable", []string{"tenant_id"})
			providerVariableBody2 := providerVariableBlock2.Body()
			providerVariableBody2.SetAttributeValue("description", cty.StringVal("The tenant_id of a service principal in the owner role for the subscription"))
			providerVariableBody2.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
			providerVariableBlock3 := newTerraformFileBody.AppendNewBlock("variable", []string{"client_id"})
			providerVariableBody3 := providerVariableBlock3.Body()
			providerVariableBody3.SetAttributeValue("description", cty.StringVal("The client_id of a service principal in the owner role for the subscription"))
			providerVariableBody3.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
			providerVariableBlock4 := newTerraformFileBody.AppendNewBlock("variable", []string{"client_secret"})
			providerVariableBody4 := providerVariableBlock4.Body()
			providerVariableBody4.SetAttributeValue("description", cty.StringVal("The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!"))
			providerVariableBody4.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
		}
		if k == "vault" {
			fmt.Printf("creating '%v' provider variables.....\n", k)
			vProviderVariableBlock1 := newTerraformFileBody.AppendNewBlock("variable", []string{"vault_url"})
			vProviderVariableBody1 := vProviderVariableBlock1.Body()
			vProviderVariableBody1.SetAttributeValue("description", cty.StringVal("hashicorp vault URL"))
			vProviderVariableBody1.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
			vProviderVariableBlock2 := newTerraformFileBody.AppendNewBlock("variable", []string{"vault_token"})
			vProviderVariableBody2 := vProviderVariableBlock2.Body()
			vProviderVariableBody2.SetAttributeValue("description", cty.StringVal("hashicorp vault token"))
			vProviderVariableBody2.SetAttributeTraversal("type", hcl.Traversal{
				hcl.TraverseRoot{
					Name: "string",
				},
			})
		}
		return newTerraformFile
	}
	return newTerraformFile
}

func (c *Creator) CreateAutoTfvars(resources []string) *hclwrite.File {
	newTerraformFile := c.CreateHCLFile()
	newTerraformFileBody := newTerraformFile.Body()
	for _, resource := range resources {
		fmt.Printf("Creating '%v' parameters in variable.auto.tfvars.....\n", resource)
		newTerraformFileBody.AppendNewline()
		newTerraformFileBody.AppendUnstructuredTokens(hclwrite.TokensForTraversal(hcl.Traversal{
			hcl.TraverseRoot{
				Name: CommentGenerator("parameters", resource),
			},
		}))
		newTerraformFileBody.AppendNewline()
		module, _ := tfconfig.LoadModule(resource)
		for _, v := range module.Variables {
			if v.Type != "" {
				newTerraformFileBody.SetAttributeTraversal(""+v.Name, hcl.Traversal{
					hcl.TraverseRoot{
						Name: c.TfvarsValueGenerator(v.Type),
					},
				})
			} else {
				newTerraformFileBody.SetAttributeValue(""+v.Name, cty.StringVal(""))
			}

		}
	}

	return newTerraformFile
}

func (c *Creator) CreateHCLFile() *hclwrite.File {
	return hclwrite.NewEmptyFile()
}

func (c *Creator) DependsOnGenerator(r string, ls []string) string {
	var s string
	for i := 0; i < len(ls); i++ {
		s = s + "module." + ls[i]
		if ls[i+1] != r {
			s = s + ", "
		}
		if ls[i+1] == r {
			break
		}
	}
	s = "[ " + s + " ]"
	return s
}

func (c *Creator) SourceGenerator(resource string) string {
	var s string
	if strings.Contains(resource, "azurerm") {
		s = strings.ReplaceAll(resource, "terraform-azurerm-", "")
	}
	s = "terraform.io/" + s + "/azurerm"
	return s
}

func CommentGenerator(blockType, resource string) string {
	var s string
	s = s + "#-------------------------------------------#\n"
	s = s + "# " + resource + " " + blockType + "!\n"
	s = s + "#-------------------------------------------#\n"
	return s
}

func (c *Creator) TfvarsValueGenerator(s string) string {
	if strings.HasPrefix(s, "object") {
		s := strings.Trim(s, "list(object({)(}{")
		for k, v := range valueReplacement {
			s = strings.ReplaceAll(s, k, v)
		}
		s = strings.ReplaceAll(s, "list(object(", "[")
		s = strings.ReplaceAll(s, "))", "]")
		return "{" + s + "}"
	}
	if strings.HasPrefix(s, "list(object") {
		s := strings.Trim(s, "list(object({)(}{")
		for k, v := range valueReplacement {
			s = strings.ReplaceAll(s, k, v)
		}
		s = strings.ReplaceAll(s, "list(object(", "[")
		s = strings.ReplaceAll(s, "))", "]")
		return "[{" + s + "}]"
	}
	if strings.HasPrefix(s, "string") {
		return "\"\""
	}
	if strings.HasPrefix(s, "list(string)") {
		return "[]"
	}
	if strings.HasPrefix(s, "list") {
		return "[]"
	}
	if strings.HasPrefix(s, "list(number)") {
		return "[]"
	}
	if strings.HasPrefix(s, "bool") {
		return "false"
	}
	if strings.HasPrefix(s, "number") {
		return "0"
	}
	if strings.HasPrefix(s, "map") {
		return "{}"
	}
	return ""
}
