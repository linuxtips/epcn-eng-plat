// main.go
package main

import (
	"fmt"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello, World")
}

func main() {
	http.HandleFunc("/", helloHandler)
	fmt.Println("Servidor rodando!")
	http.ListenAndServe(":8080", nil)
}
