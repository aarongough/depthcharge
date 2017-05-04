require "spec_helper"

RSpec.describe Depthcharge::RequestLogger do

  let(:env) { Rack::MockRequest.env_for("/blah?foo=1", "HTTP_VERSION" => "HTTP/1.1") }
  let(:logger) { Depthcharge::RequestLogger.new(env, "200", {"Content-Type" => "text/html"}, ["Body"]) }

  describe ".initialize" do
    it "stores the request" do
      expect(logger.env).to eq(env)
      expect(logger.status).to eq("200")
      expect(logger.headers).to eq({"Content-Type" => "text/html"})
      expect(logger.body).to eq(["Body"])
    end
  end

  describe "#construct_log_entry" do
    it "generates a log entry containing all the needed information" do
      log = logger.construct_log_entry

      expect(log).to include("blah")
      expect(log).to include("200")
      expect(log).to include("foo")
      expect(log).to include("1")
      expect(log).to include("HTTP_VERSION")
      expect(log).to include("Content-Type")
      expect(log).to include("text/html")
      expect(log).to include("Body")
    end
  end

  describe "#log" do
    let(:output1) { spy(:IO) }
    let(:output2) { spy(:IO) }

    it "writes to each of the log outputs given" do
      logger.log([output1, output2])

      expect(output1).to have_received(:puts).with(logger.construct_log_entry)
      expect(output2).to have_received(:puts).with(logger.construct_log_entry)
    end

    it "should flush each output after writing" do
      logger.log([output1, output2])

      expect(output1).to have_received(:flush)
      expect(output2).to have_received(:flush)
    end
  end
end
