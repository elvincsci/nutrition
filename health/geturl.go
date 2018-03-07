package main


import (
	nokiahealth "health/nokiahealth"
	"net/http"
	"encoding/json"
	//"os"
	"io"
	//"fmt"
)

type urls struct {
	Status_Message    string
	Url_Link 	string
}




func main() {

	http.HandleFunc("/geturl", func(ress http.ResponseWriter, reqq *http.Request) {

	client := nokiahealth.NewClient("cb2962c175cd3bc6095e5bb091d5ef6f65e1c079b9b3dffc93794c8e2d2e1", "854b19b04fd83e7b65b34fb77eec84c9bf34c1c0ed0813153d17119f", "http://localhost:8080/example")
	client.SaveRawResponse = true

	ar, err := client.CreateAccessRequest()

		if err != nil {
		//log.Fatal(err)

			//fmt.Println("test")

			urlLink := urls{"error","error"}

			jss, err := json.Marshal(urlLink)

			if err != nil {
				http.Error(ress, err.Error(), http.StatusInternalServerError)
				return
			}

			ress.Header().Set("Content-Type", "application/json")

			ress.Write(jss)


		}else {

			urlString := ar.AuthorizationURL.String()

			urlLink := urls{Status_Message:"success",Url_Link:urlString}

			jss, err := json.Marshal(urlLink)

			if err != nil {
				http.Error(ress, err.Error(), http.StatusInternalServerError)
				return
			}

			ress.Header().Set("Content-Type", "application/json")

			//os.Stdout.Write(jss)
			//io.WriteString(ress, "["+string(jss)+"]")
			io.WriteString(ress, string(jss))

			//ress.Header().Set("Content-Type", "application/json")

			//ress.Write('[',jss,"]")

			//ress

		}

	})


	http.ListenAndServe(":8080", nil)


}

