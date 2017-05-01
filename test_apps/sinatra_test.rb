require "bundler/setup"
require "depthcharge"
require "sinatra/base"
require "json"

class SinartraTestApp < Sinatra::Base
  use Depthcharge::Middleware

  get "/example.json" do
    content_type :json
    {a: 1, b: 2, c: 3, d: 4}.to_json
  end

  run!
end
