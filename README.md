# ruby-riminder-api

-------------------------------------

A ruby api client for Riminder api.

## Instalation with ruby gems

```shell
gem install Riminder
```

## Authentification

To authenticate against the api, get your API SECRET KEY from your riminder dashboard: 
![findApiSecret](./secretLocation.png)

Then create a new `Riminder` object with this key:

```ruby
    require 'riminder'

    # Authentification to api
    client = Riminder.new("your shiny key")

    # Finally you can use the api!!
```

## Api overview

```ruby
    require 'riminder'


    client = Riminder.new("your shiny key")

    # Let's retrieve a profile.
    profile = client.profile.get "source_id" => "a source id", 
        "profile_id" => "id of the profile"

    # And print his name !
    puts("This profile name is %s" [profile['name']])
```

## Errors

If an error occurs while an operation an exception inherited from `RiminderException` is raised.

```ruby
    require 'riminder'
    require 'riminderException'


    client = Riminder.new("your shiny key")

    begin
        profile = client.profile.get "source_id" => "a source id",
             "profile_id" => "id of the profile"
    rescue => RiminderException
        # some treatment.
    end
```

## Api

The mentionned team is the team linked to your secret key.

When both `*_id` and `*_reference` arguments are requested only one is requiered.
For example `client.filter.get()` can take a

* `filter_id` (`client.filter.get "filter_id" => filter_id`)
* `filter_reference` (`client.filter.get "filter_reference" => filter_reference`)

and work as well.

Only the `data` field will be returned by methods.

For details and examples see [our documentation](https://developers.Riminder.net/v1.0/reference).

### Filter

* Get all filters from the team.
  * returns: Array of Hash containing the filters.

```ruby
resp = client.filter.list
```

* Get a specific filter.
  * Arguments: Hash containing
    * `"filter_id"` id of the filter (*required*)
    * `"filter_reference"` reference of the filter (*required*)
  * Returns: Hash containing the filter.

```ruby
resp = client.filter.get "filter_id" => "a filter id"
```

More details about filters are available [here](https://developers.Riminder.net/v1.0/reference#jobs)

### Profile

* Retrieve the profiles information associated with specified source ids.
  * Arguments: Hash containing
    * `"source_ids"` Array of source ids (*requiered*)
    * `"seniority"` profile's seniority
    * `"filter_id"` filter id (to sort by filter stage and/or rating)
    * `"filter_reference"` filter_reference (to sort by filter stage and/or rating)
    * `"stage"` stage (to sort by filter stage and/or rating)
    * `"rating"` rating (to sort by filter stage and/or rating)
    * `"date_start"` profile's first date of reception (default 9/9/2012)
    * `"date_end"` profile's last date of reception (default: now)
    * `"page"` selected page (default: 1)
    * `"limit"` number of result by page
    * `"sort_by"` sort profile by (default: ranking)
    * `"order_by"` order profile by
  * Returns: Array of Hash containing the profiles

```ruby
resp = client.profile.list "source_ids" => source_ids, "seniority" => "all", "page" => 2, "limit" => 5
```

* Add a new profile to a source on the platform.
  * Arguments: Hash containing
    * `"filepath"` path of the file to be uploaded. (*required*)
    * `"source_id"` id of the target source. (*required*)
    * `"timestamp_reception"` reception's timestamp
    * `"profile_reference"` reference for the new profile
    * `"training_metadata"` training metadatas to add.
  * Returns: Hash containing upload result.

```ruby
resp = client.profile.add "filepath" => "path/to/file", "source_id" => source_id, "profile_reference" => "reference0"
```

* Get a specific profile.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
  * Returns: Hash containing the profile.

```ruby
resp = client.profile.get "source_id" => source_id, "profile_reference" => profile_reference
```

* Get attachements of a specific profile.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
  * Returns: Array of Hash containing the profile attachements.

```ruby
resp = client.profile.document.list "source_id" => source_id, "profile_id" => profile_id
```

* Get parsing result of a specific profile.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
  * Returns: Hash containing the profile parsing.

```ruby
resp = client.profile.parsing.get "source_id" => source_id, "profile_id" => profile_id
```

* Get scoring result of a specific profile.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
  * Returns: Array of Hash containing the profile scoring.

```ruby
resp = client.profile.scoring.list "source_id" => source_id, "profile_reference" => profile_reference
```

* Reveal the interpretability result of a specific profile.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
    * `"filter_id"` id of the target filter (*required*)
    * `"filter_reference"` reference of the target filter (*required*)
  * Returns: Array of Hash containing the profile's scores for the specified filter.

```ruby
resp = client.profile.reveal.get "source_id" => source_id, "profile_id" => profile_id, "filter_reference" => filter_reference
```

* Set stage of a specific profile for a spcified filter.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
    * `"filter_id"` id of the target filter (*required*)
    * `"filter_reference"` reference of the target filter (*required*)
    * `"stage"` new stage
  * Returns: Hash containing operation result.

```ruby
resp = client.profile.stage.set "source_id" => source_id, "profile_id" => profile_id, "filter_reference" => filter_reference, "stage" => "YES"
```

* Set rating of a specific profile for a spcified filter.
  * Arguments: Hash containing
    * `"source_id"` id of the source containing the profile (*required*)
    * `"profile_id"` id of the profile (*required*)
    * `"profile_reference"` reference of the profile (*required*)
    * `"filter_id"` id of the target filter (*required*)
    * `"filter_reference"` reference of the target filter (*required*)
    * `"stage"` new stage
  * Returns: Hash containing operation result.

```ruby
resp = client.profile.rating.set "source_id" => source_id, "profile_id" => profile_id, "filter_reference" => filter_reference, "rating" => 3
```

* Check if a parsed profile is valid.
  * Arguments: Hash containing
    * `"profile_json"` profile data to check. (*required*)
    * `"training_metadata"` training metadatas to add.
  * Returns: Hash containing upload result.

```ruby
resp = client.profile.json.check "profile_json" => profile_datas
```

* Add a parsed profile to a source on the platform.
  * Arguments: Hash containing
    * `"profile_json"` profile data to upload. (*required*)
    * `"source_id"` id of the target source. (*required*)
    * `"timestamp_reception"` reception's timestamp
    * `"profile_reference"` reference for the new profile
    * `"training_metadata"` training metadatas to add.
  * Returns: Hash containing upload result.

```ruby
resp = client.profile.json.add "profile_json" => profile_datas, "source_id" => "a source_id", "timestamp_reception" => 1347209668
```

More details about profiles are available [here](https://developers.Riminder.net/v1.0/reference#profile)

### Sources

* Get all source from the team.
  * returns: Array of Hash containing the sources.

```ruby
resp = client.source.list
```

* Get a specific source.
  * Arguments: 
    * source_id -> id of the source to retrieve.
  * Returns: Hash containing a specific source.

```ruby
resp = client.source.get "source_id"
```

More details about profiles are available [here](https://developers.Riminder.net/v1.0/reference#source)

### Webhooks

Webhooks methods permit you handle webhook events.
To handle event a webhook key is needed to be passed at Riminder object creation: `Riminder.new("api_key", "webhook key")`

* Check if team's webhook integration is working.
  * Returns: Hash containing operation result.

```ruby
resp = client.webhooks.check 
```

* Set an handler for a specified webhook event.
  * Arguments:
    * eventName -> name of the target event
    * callback -> callable called when target webhook is received.
      * takes 2 args:
        * eventName: name of the event (type field of webhooks)
        * payload: webhooks datas

```ruby
client.webhooks.setHandler("profile.parse.success", handler);
```

* Check if there is an handler for a specified event
  * Arguments:
    * eventName -> target event name

```ruby
client.webhooks.isHandlerPresent(eventName);
```

* Remove the handler for an event
  * Arguments:
    * eventName -> target event name

```ruby
client.webhooks.removeHandler(eventName);
```

* Start the selected handler depending of the event given.
  * Arguments:
    * receivedMessage -> received webhook request's headers as a Hash or the content of received webhook request's `"HTTP-RIMINDER-SIGNATURE"`header.

```ruby
client.webhooks.handle(receivedHeader)
```

Example:

```ruby
client = Riminder.new("an api key", "webhook_key")

cb  = -> (event_type, event_data) {
    # some treatment here
}
api.webhooks.setHandler "profile.parse.success", cb

encodedHeader = get_webhook_headers()
api.webhooks.handle encodedHeader
```

More details about webhooks are available [here](https://developers.Riminder.net/v1.0/reference#authentication-1)

## Tests

Some tests are available. To run them follow these steps:

* `git clone git@github.com:Riminder/ruby-riminder-api.git`
* `cd ruby-riminder-api`
* `bundle install`
* `rspec --format doc`

## Help and documentation

If you need some more details about the api methods and routes see [Riminder API Docs](https://developers.Riminder.net/v1.0/reference).

If you need further explainations about how the api works see [Riminder API Overview](https://developers.riminder.net/v1.0/docs/website-api-overview) 