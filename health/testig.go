package main

import (
	"net/url"
	"fmt"

)


func main() {

	u, _ := url.Parse("http://bing.com/search?q=dotnet")


	u.Scheme = "nutrition"
	u.Host = "google.com"
	q := u.Query()
	q.Set("q", "golang")
	u.RawQuery = q.Encode()
	fmt.Println(u)
}