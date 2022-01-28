package s3c

import (
	"fmt"

	"log"
	"os"

	"strings"

	"github.com/hashicorp/terraform-config-inspect/tfconfig"
)

var gitRepos []string

type S3C struct {
	Collator *Collator
	Creator  *Creator
	Labels   []string
}

func (s *S3C) ToBeCloned(repos []string) {
	for _, n := range repos {
		if _, err := os.Stat(n); os.IsNotExist(err) {
			gitRepos = append(gitRepos, n)
		}
	}
}

func (s *S3C) CreateStackFromModules(dirName string, repos []string) {
	os.MkdirAll(dirName, os.ModePerm)
	s.Collator.Clone(gitRepos)
	s.CreateAndWrite(dirName+"/provider.tf", s.Creator.CreateProviderBlock(repos).Bytes())
	s.CreateAndWrite(dirName+"/provider-variables.tf", s.Creator.CreateProviderVariableBlocks(repos).Bytes())
	s.CreateAndWrite(dirName+"/variables.tf", s.Creator.CreateVariableBlocks(repos).Bytes())
	s.CreateAndWrite(dirName+"/version.tf", s.Creator.CreateTerraformBlock(repos).Bytes())
	s.CreateAndWrite(dirName+"/main.tf", s.Creator.CreateModuleBlock(repos).Bytes())
	s.CreateAndWrite(dirName+"/variables.auto.tfvars", s.Creator.CreateAutoTfvars(repos).Bytes())
	module, _ := tfconfig.LoadModule(dirName)
	done := capture()
	tfconfig.RenderMarkdown(os.Stdout, module)
	o, _ := done()
	s.CreateAndWrite(dirName+"/README.md", []byte(o))
	s.CleanUp(repos)

}

func (s *S3C) CleanUp(repos []string) {
	var dirNames []string
	for _, url := range s.Collator.RepoUrls(gitRepos) {
		dirNames = append(dirNames, strings.ReplaceAll(strings.Split(url, "/")[len(strings.Split(url, "/"))-1], ".git", ""))
	}
	for _, dir := range dirNames {
		err := os.RemoveAll(dir)
		if err != nil {
			fmt.Println(err)
		}
	}
}

func (s *S3C) CreateAndWrite(fileName string, fileData []byte) {
	// If the file doesn't exist, create it, or append to the file
	f, err := os.OpenFile(fileName, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	if _, err := f.Write(fileData); err != nil {
		f.Close() // ignore error; Write error takes precedence
		log.Fatal(err)
	}
	if err := f.Close(); err != nil {
		log.Fatal(err)
	}
}

func (s *S3C) Args() (string, string, []string) {
	repoType, dir, reponames, err := SubCommand("repos", "path")
	if err != nil {
		fmt.Println(err)
		return "", "", nil
	}
	return repoType, dir, reponames

}
