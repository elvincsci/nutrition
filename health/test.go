package main

import (
	//"time"
	"strconv"
	//"net/url"
	//"strconv"
	"fmt"
	nokiahealth "health/nokiahealth"
	//types "health/nokiahealth/types.go"

	//"io"
	"net/http"
	//"github.com/BurntSushi/toml"
	//"time"
	"encoding/json"
	"os"
)

var StartTime = nokiahealth.AccessRequest{}

type Profile struct {
	TokenStr    string
	SecretStr 	string
	UserID     	int
}


func main() {

	http.HandleFunc("/geturl", geturls)



	http.HandleFunc("/example", func(res http.ResponseWriter, req *http.Request) {
		//queryParamDisplayHandler(res, req)

		userid := req.FormValue("userid")
		verifier := req.FormValue("oauth_verifier")
		intUserid, err := strconv.Atoi(userid)

		u, err := StartTime.GenerateUser(verifier, intUserid)

		//fmt.Println("---------------1", u.AccessTokenStr)
		//fmt.Println("---------------2", u.AccessSecretStr)


		if err != nil {
			fmt.Println("failed to get body measurements: %v", err)

			profile := Profile{"error", "error", 0}

			js, err := json.Marshal(profile)
			if err != nil {
				http.Error(res, err.Error(), http.StatusInternalServerError)
				return
			}

			res.Header().Set("Content-Type", "application/json")
			res.Write(js)

		}else {

			profile := Profile{u.AccessTokenStr, u.AccessSecretStr,intUserid}

			js, err := json.Marshal(profile)
			if err != nil {
				http.Error(res, err.Error(), http.StatusInternalServerError)
				return
			}

			res.Header().Set("Content-Type", "application/json")
			res.Write(js)
		}




		//ee := client.GenerateUser(u.AccessTokenStr, u.AccessSecretStr, intUserid)


		//startDate := time.Now().AddDate(-2, 0, -2)
		//endDate := time.Now()
		//
		//
		//p := nokiahealth.BodyMeasuresQueryParams{
		//	StartDate: &startDate,
		//	EndDate:   &endDate,
		//}
		//
		//s, err := ee.GetBodyMeasures(&p)
		//
		//
		//fmt.Println("Body  ", s.Body.MeasureGrps)
		//
		//
		// if err != nil {
		// 	fmt.Println("failed to get body measurements: %v", err)
		// }




		})

	//AccessRequest := nokiahealth.GenerateUser(verifier,intUserid)

	http.ListenAndServe(":8080", nil)



}


func geturls(ress http.ResponseWriter, reqq *http.Request) {

	client := nokiahealth.NewClient("cb2962c175cd3bc6095e5bb091d5ef6f65e1c079b9b3dffc93794c8e2d2e1", "854b19b04fd83e7b65b34fb77eec84c9bf34c1c0ed0813153d17119f", "http://localhost:8080/example")
	client.SaveRawResponse = true

	ar, err := client.CreateAccessRequest()
	if err != nil {
		//log.Fatal(err)
		fmt.Println("test")
	}

	StartTime = ar

	fmt.Println(ar.AuthorizationURL)

	http.Redirect(ress, reqq, ar.AuthorizationURL.String(), 301)

}