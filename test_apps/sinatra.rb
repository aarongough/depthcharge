# Run this app with: `ruby sinatra.rb`

require "bundler/setup"
require "depthcharge"
require "sinatra/base"
require "json"

class SinartraTestApp < Sinatra::Base
  use Depthcharge::Middleware, STDOUT, File.open("sinatra-depthcharge.log", "w")

  get "/example.json" do
    content_type :json
    { a: 1, b: 2, c: 3, d: 4 }.to_json
  end

  get "/example.html" do
    "<head><head/><body><span>Example text</span></body>"
  end

  run!
end
