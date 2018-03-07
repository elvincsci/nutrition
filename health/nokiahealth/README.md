# Go client for the Nokia Health API

This is a go client that allows easy access to the Nokia Health API (https://developer.health.nokia.com/api/doc). More detailed documentation can be found in the godocs (https://godoc.org/github.com/jrmycanady/nokiahealth).

**NOTICE** - Looking for users with data from various withings devices. Currently only testing against an account with a withings scale. The API documentation is very sketchy and testing against real data may find more issues.


## Oauth Notes

The Nokia Health OAuth implemenation required some modifcations resulting in a fork of dghubble/oauth1. This project relies on the fork located at jrmycanady/oauth1. 

## Supported Resources (Currently all in the public API docs.)
* User Access Requests
* Retrieving user body measurements
* Retrieve activity measurments
* Retrieve workouts
* Retreive intraday activities - Apparently requires additional authorization wich I don't have yet so no testing.
* Retrieve sleep measures - Limited testing so report any issues.
* Retrieve sleep summary - Limited testing so report any issues.
* Creating a notification
* Retreiving a single notification
* Retreiving all notifications for a user
* Revoke notifications

## Installation
  go get github.com/jrmycanady/nokiahealth

## Basic Usage

All requests to the api for data requires a valid authenticated user token. You will first need to register as [Nokia Health developer](https://developer.health.nokia.com/partner/add).

Once that is complete, you will need to request a token for the user. If you are the user, you can perform this via the [api site](https://developer.health.nokia.com/api). On the other hand if you are develping an application for end users you will need to utilize the token request process detailed below.

### User Authorization

Oauth1 has a multi step request process to generate a token for the end user. Details around this can be found [here](https://developer.health.nokia.com/api) as well as general searching. A short example is show below but for further information see the [godcos](https://godoc.org/github.com/jrmycanady/nokiahealth)

1. Generate end-user authorization url and provide it to the end user to click on. This URL is encoded in such a way that Nokia knows the user is requesting to give your develper account access to theirs.

```go
client := nokiahealth.NewClient("<consumer_key>"," <consumer_secret>", "<callback_url>")

ar, err := client.CreateAccessRequest()
if err != nil {
    log.Fatal(err)
}

fmt.Println(ar.AuthorizationURL)
```
2. If you provided a callback URL nokia will then redirect them to that URL with queyr parameters set containing the verfier string and userid. Otherwise if it's empty the user will see it on screen and would need to copy and paste it into your app. Once you have those two bits of info, it's time to get the token.
```go
u, err := ar.GenerateUser("<verifier>", <userid>)
if err != nil {
    log.Fatal(err)
}
```
3. If all has gone well you now have a user object you may use to query. Methods off the user object include things like GetBodyMeasure()
4. Save the UseriD, AccessTokenStr and AccessSecretStr for later requets.

### User Requests

Users requests require a valid User struct. This can be obtained via the token request process as above but more likely via directly creating a User as seen below.

```go
client := nokiahealth.NewClient("<consumer_key>"," <consumer_secret>", "<callback_url>")

u := client.GenerateUser("<token>", "<secret>", "<userID>")
```

Now that the user is defined api calls can be made for the user.
```go
m, err := u.GetBodyMeasures(nil)
```


## Making Requests
Requests are performed from methods on the User. Each request accepts a specific query struct with the details for the request. For example: 
```go
p := nokiahealth.BodyMeasuresQueryParams{}

t := time.Now().AddDate(0, 0, -14)
p.StartDate = &t

m, err := u.GetBodyMeasures(&p)
```

In most cases the response will contain all the information you need. Some methods provide additional optional processing that can provide a more usable form to the data. GetBodyMeasures is one of these methods. It's recommended to read the [docs](https://godoc.org/github.com/jrmycanady/nokiahealth) for each method to see how best to use them. 

```go
measures := m.ParseData()
```