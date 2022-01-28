package tfgenerator

import (
	"bytes"
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"

	"github.com/google/go-github/github"
	"golang.org/x/oauth2"
)

type Collator struct{}

// Function to get github repo clone url
func (c *Collator) RepoUrls(repos []string) []string {
	var repoUrls []string
	ctx := context.Background()
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: os.Getenv("GH_TOKEN")},
	)
	tc := oauth2.NewClient(ctx, ts)

	client := github.NewClient(tc)

	// list all repositories for the authenticated user
	for _, repo := range repos {

		repoUrl, _, err := client.Repositories.Get(ctx, os.Getenv("ORG"), repo)
		if err != nil {
			log.Fatal(err)
		}
		repoUrls = append(repoUrls, repoUrl.GetCloneURL())

	}
	return repoUrls
}

func (c *Collator) Clone(repos []string) {
	for _, repoUrl := range c.RepoUrls(repos) {
		fmt.Printf("Cloning '%v'...\n", repoUrl)
		cmd := exec.Command("git", "clone", repoUrl)
		var stderr bytes.Buffer
		cmd.Stderr = &stderr
		err := cmd.Run()
		if err != nil {
			fmt.Println(fmt.Sprint(err) + ": " + stderr.String())
		}
	}
}
