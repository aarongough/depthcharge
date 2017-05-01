module Depthcharge
  module Filters

    def request_headers(env)
      env.select {|k,v| k.to_s.include?("HTTP") }
    end

    def request_params(env)
      request = Rack::Request.new(env)
      request.params
    end

  end
end