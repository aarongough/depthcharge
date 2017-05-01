require "spec_helper"

RSpec.describe Depthcharge::Filters do

  include Depthcharge::Filters

  describe "#request_headers" do
    it "returns only HTTP headers" do
      env = Rack::MockRequest.env_for("/", "HTTP_VERSION" => "HTTP/1.1")
      keys = request_headers(env).keys

      expect(keys).to contain_exactly("HTTPS", "HTTP_VERSION")
    end
  end

  describe "#request_params" do
    it "returns the request params" do
      env = Rack::MockRequest.env_for("/?foo=1")
      keys = request_params(env).keys

      expect(keys).to contain_exactly("foo")
    end
  end
  
end
