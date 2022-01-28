package tfgenerator

var valueReplacement = map[string]string{
	"string":     "\"\"",
	"list(\"\")": "[]",
	"number":     "0",
	"bool":       "false",
}

var repoDatabase = map[string]string{}
