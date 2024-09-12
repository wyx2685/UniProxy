package v2b

import (
	"testing"
)

func TestGetServers(t *testing.T) {
	var url []string
	url = append(url, "http://127.0.0.1")
	Init("", url, "xxxxxxxxx")
	t.Log(GetServers())
}
