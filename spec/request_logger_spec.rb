require "spec_helper"

RSpec.describe Depthcharge::RequestLogger do

  describe ".initialize" do
    it "stores the request" do
      logger = Depthcharge::RequestLogger.new(:a, :b, :c, :d)

      expect(logger.env).to eq(:a)
      expect(logger.status).to eq(:b)
      expect(logger.headers).to eq(:c)
      expect(logger.body).to eq(:d)
    end
  end
end
