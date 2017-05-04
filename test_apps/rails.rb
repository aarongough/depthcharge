# Run this app with: `ruby rails.rb`

require "bundler/setup"
require "depthcharge"
require "rails"
require "webrick"
require "json"
require "action_controller/railtie"

class MyApp < Rails::Application
  routes.append do
    get "/example.json" => "example#json"
  end

  config.eager_load = true
  config.secret_key_base = "538f51b191c9c2c35496d55804ddeddf"

  config.middleware.use Depthcharge::Middleware, STDOUT, Rails.root.join("rails-depthcharge.log")
end

class ExampleController < ActionController::Base
  def json
    render json: { a: 1, b: 2, c: 3, d: 4 }
  end
end

MyApp.initialize!

# Open a browser pointing at the server automtically on OSX
`open http://localhost:3000/example.json`

Rack::Handler::WEBrick.run(MyApp, :Port => 3000)