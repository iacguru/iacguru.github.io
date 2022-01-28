package s3c

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"strings"

	"github.com/google/go-github/github"
	"github.com/hashicorp/terraform-config-inspect/tfconfig"
	"golang.org/x/oauth2"
)

// return bool if list contains a string
func contains(s []string, str string) bool {
	for _, v := range s {
		if v == str {
			return true
		}
	}

	return false
}

// return list with uniq elements
func unique(e []string) []string {
	r := []string{}

	for _, s := range e {
		if !Contains(r[:], s) {
			r = append(r, s)
		}
	}
	return r
}

// Function to get github repo tags
func tags(pat, owner, repo string) []string {
	var tags []string
	ctx := context.Background()
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: pat},
	)
	tc := oauth2.NewClient(ctx, ts)

	client := github.NewClient(tc)

	// list all repositories for the authenticated user
	repoTags, _, err := client.Repositories.ListTags(ctx, owner, repo, nil)
	if err != nil {
		log.Fatal(err)
	}
	for _, tag := range repoTags {
		tags = append(tags, tag.GetName())
	}
	return tags
}

func capture() func() (string, error) {
	r, w, err := os.Pipe()
	if err != nil {
		panic(err)
	}

	done := make(chan error, 1)

	save := os.Stdout
	os.Stdout = w

	var buf strings.Builder

	go func() {
		_, err := io.Copy(&buf, r)
		r.Close()
		done <- err
	}()

	return func() (string, error) {
		os.Stdout = save
		w.Close()
		err := <-done
		return buf.String(), err
	}
}

func showModuleMarkdown(module *tfconfig.Module) {
	err := tfconfig.RenderMarkdown(os.Stdout, module)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error rendering template: %s\n", err)
		os.Exit(2)
	}
}

func SubCommand(cmd1, cmd2 string) (string, string, []string, error) {
	var err error
	arg1 := flag.String(cmd1, "", "A comma seperated repo names.")
	arg2 := flag.String(cmd2, "", "Directory path to create tf files.")
	arg3 := flag.String("type", "", "is repo template or module, default module.")
	flag.Parse()
	if *arg1 == "" {
		err = errors.New("A comma seperated repo names required!")
		fmt.Println(err)
		flag.PrintDefaults()
		os.Exit(1)
	}
	if *arg2 == "" {
		err = errors.New("Path required to create tf files!")
		fmt.Println(err)
		flag.PrintDefaults()
		os.Exit(1)
	}
	switch *arg3 {
	case "templates":
		*arg3 = "templates"
	default:
		*arg3 = "modules"
	}

	return *arg3, *arg2, strings.Split(*arg1, ","), err
}
