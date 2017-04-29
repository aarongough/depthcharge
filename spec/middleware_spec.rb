require "spec_helper"

RSpec.describe Depthcharge::Middleware do
  let(:app) { spy(:app) }
  let(:env) { spy(:env) }

  let(:middleware) { Depthcharge::Middleware.new(app) }

  describe ".initialize" do
    it "stores the app correctly" do
      expect(middleware.app).to eq(app)
    end
  end

  describe "#call" do
    it "calls the provided app and passes on environment" do
      middleware.call(env)
      expect(app).to have_received(:call).with(env)
    end

    it "returns the result of calling the app" do
      allow(app).to receive(:call).and_return(:result)
      expect(middleware.call(env)).to eq(:result)
    end
  end
end
