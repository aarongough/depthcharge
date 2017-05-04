# Depthcharge

Depthcharge is a piece of Rack middleware that enables extra visibility into the requests going through an application. The primary use case for this is to see the requests that are coming and going from a local server to a connected client app (like iOS simulator for example). Additionally it will automatically detect JSON responses and pretty print them to enhance readability.

## Example log output


	GET 200 "/example.json" at 2017-04-30 23:32:16 -0400
	  | PARAMS:
	  |   test: "foo"
	  |
	  | REQUEST HEADERS:
	  |   HTTP_HOST: "localhost:4567"
	  |   HTTP_CONNECTION: "keep-alive"
	  |   HTTP_CACHE_CONTROL: "max-age=0"
	  |   HTTP_VERSION: "HTTP/1.1"
	  |
	  | RESPONSE STATUS: 200
	  |
	  | RESPONSE HEADERS:
	  |   Content-Type: "application/json"
	  |   Content-Length: "25"
	  |
	  | BODY:
	  |   {
	  |     "a": 1,
	  |     "b": 2,
	  |     "c": 3,
	  |     "d": 4
	  |   }
	  |



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

Just add `gem 'depthcharge'` to your app's Gemfile, then add the middleware to your app like so:

Sinatra:
```ruby
use Depthcharge::Middleware, STDOUT, "depthcharge.log"
```

Rails:
```ruby
# config/application.rb (or)
config.middleware.use Depthcharge::Middleware, Rails.root.join("log", "depthcharge.log")
```

You can pass multiple outputs to Depthcharge::Middleware and it will write to each one for each request. Logging to `STDOUT` and a log file simultaneously is a handy use of this as demonstrated above with the Sinatra setup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

