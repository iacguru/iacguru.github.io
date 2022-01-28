package main

import (
	s3c "github.com/iacguru/iacguru.github.io/IaC Template Generator/Terraform"
)

func main() {
	s := s3c.S3C{}
	repoType, dirName, repos := s.Args()
	s.ToBeCloned(repos)
	if repoType == "modules" {
		s.CreateStackFromSeModules(dirName, repos)
	}
}
