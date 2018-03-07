package main

import (
	"fmt"
	"net/http"
	"encoding/json"
	"io"
	"health/nokiahealth"
	"strconv"
	//"os"
	//"net/url"
)

var StartTimes = nokiahealth.AccessRequest{}

type urlss struct {
	Status_Message    string
	Url_Link 	string
}

type Profilee struct {
	TokenStr    string
	SecretStr 	string
	UserID     	int
}


func geturl(ress http.ResponseWriter, reqq *http.Request) {
//	fmt.Fprintf(w, "It's adminHandlerOne , Hello, %q", r.URL.Path[1:])

//	client := nokiahealth.NewClient("cb2962c175cd3bc6095e5bb091d5ef6f65e1c079b9b3dffc93794c8e2d2e1", "854b19b04fd83e7b65b34fb77eec84c9bf34c1c0ed0813153d17119f", "http://localhost:8080/example")
	client := nokiahealth.NewClient("cb2962c175cd3bc6095e5bb091d5ef6f65e1c079b9b3dffc93794c8e2d2e1", "854b19b04fd83e7b65b34fb77eec84c9bf34c1c0ed0813153d17119f", "nutrition://")


	client.SaveRawResponse = true

	ar, err := client.CreateAccessRequest()

	StartTimes = ar

	if err != nil {
		//log.Fatal(err)

		//fmt.Println("test")

		urlLink := urlss{"error","error"}

		jss, err := json.Marshal(urlLink)

		if err != nil {
			http.Error(ress, err.Error(), http.StatusInternalServerError)
			return
		}

		ress.Header().Set("Content-Type", "application/json")

		ress.Write(jss)


	}else {

		urlString := ar.AuthorizationURL.String()

		urlLink := urlss{Status_Message:"success",Url_Link:urlString}

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

}

func getuserrequests(res http.ResponseWriter, req *http.Request) {

	userid := req.FormValue("userid")
	verifier := req.FormValue("oauth_verifier")
	intUserid, err := strconv.Atoi(userid)

	u, err := StartTimes.GenerateUser(verifier, intUserid)

	//fmt.Println("---------------1", u.AccessTokenStr)
	//fmt.Println("---------------2", u.AccessSecretStr)

	if err != nil {
		fmt.Println("failed to get body measurements: %v", err)

		profile := Profilee{"error", "error", 0}

		js, err := json.Marshal(profile)
		if err != nil {
			http.Error(res, err.Error(), http.StatusInternalServerError)
			return
		}

		res.Header().Set("Content-Type", "application/json")
		res.Write(js)

	}else {

		profile := Profilee{u.AccessTokenStr, u.AccessSecretStr,intUserid}

		js, err := json.Marshal(profile)
		if err != nil {
			http.Error(res, err.Error(), http.StatusInternalServerError)
			return
		}

		res.Header().Set("Content-Type", "application/json")
		res.Write(js)


		//http.Redirect(res, req, "http://"+"localhost:8080/example", 301)

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

}



func main() {
	http.HandleFunc("/geturl", geturl)
	//http.HandleFunc("/getuserrequests", getuserrequests)

	http.HandleFunc("/example", getuserrequests)


	http.ListenAndServe(":8080", nil)
}