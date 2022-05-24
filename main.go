package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/http", helloHandle)
	http.ListenAndServe(":8080", nil)
}

func helloHandle(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello world...")
}
