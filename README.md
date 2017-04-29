# Depthcharge

Depthcharge adds extra logging to `ActionController::Base` in Rails to make it easier to see the requests that are coming and going from a local server to a connected client app (like iOS simulator for example). It will automatically detect JSON responses and pretty print them as well.

# Example log output


	GET "/listings/ads" at 2017-04-28 14:14:34 -0400
	  | 
	  | PARAMS:
	  | 	{"controller"=>"listings", "action"=>"ads"}
	  |
	  | HEADERS:
	  |     HTTP_HOST: "127.0.0.1:3000"
	  |     HTTP_X_API_VERSION: "1.7.13"
	  |     HTTP_CONNECTION: "keep-alive"
	  |     HTTP_X_COUNTRY_CODE: "US"
	  |     HTTP_IF_NONE_MATCH: "W/\"b3855e44a25de3970bf42c6f35f119b4\""
	  |     HTTP_ACCEPT: "application/json"
	  |     HTTP_USER_AGENT: "someApp/5.23.0 iOS/10.2 (iPhone; Retina, Simulator, 1242x2208)"
	  |     HTTP_ACCEPT_LANGUAGE: "en;q=1"
	  |     HTTP_CACHE_CONTROL: "max-age=0"
	  |     HTTP_ACCEPT_ENCODING: "gzip, deflate"
	  |     HTTP_VERSION: "HTTP/1.1"
	  | 
	  | RESPONSE:
	  |     STATUS: 200
	  |     BODY:
	  |        {
	  |          "ads":{
	  |             "banner":{
	  |                "banner_ad":"Buy Slurm!"
	  |             }
	  |          }
	  |        } 



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'depthcharge'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install depthcharge

## Usage

Just add `gem 'depthcharge'` to your app's Gemfile, preferable in the `development` group.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

