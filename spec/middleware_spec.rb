require "spec_helper"

RSpec.describe Depthcharge::Middleware do
  let(:app) { spy(:app) }
  let(:env) { spy(:env) }

  let(:middleware) { Depthcharge::Middleware.new(app) }

  describe ".initialize" do
    it "stores the app correctly" do
      expect(middleware.app).to eq(app)
    end

    it "allows multiple outputs" do
      file = double(:file)
      allow(File).to receive(:open).and_return(file)

      middleware = Depthcharge::Middleware.new(app, "foo.log", "bar.log")
      expect(middleware.outputs).to match_array([file, file])
    end

    it "converts a string output to a File " do
      file = double(:file)
      allow(File).to receive(:open).and_return(file)
      middleware = Depthcharge::Middleware.new(app, "foo.log")

      expect(File).to have_received(:open).with("foo.log", "w")
      expect(middleware.outputs.first).to eq(file)
    end

    it "converts a Pathname output to a File" do
      file = double(:file)
      allow(File).to receive(:open).and_return(file)
      middleware = Depthcharge::Middleware.new(app, Pathname.new("foo.log"))

      expect(File).to have_received(:open)
      expect(middleware.outputs.first).to eq(file)
    end
  end

  describe "#call" do
    before do
      allow_any_instance_of(Depthcharge::RequestLogger).to receive(:log).and_return(:foo)
    end

    it "calls the provided app and passes on environment" do
      middleware.call(env)
      expect(app).to have_received(:call).with(env)
    end

    it "returns the result of calling the app" do
      allow(app).to receive(:call).and_return([:a, :b, :c])
      expect(middleware.call(env)).to eq([:a, :b, :c])
    end

    it "creates a new instance of RequestLogger" do
      allow(app).to receive(:call).and_return([:a, :b, :c])
      allow(Depthcharge::RequestLogger).to receive(:new).and_return(spy)

      middleware.call(env)
      expect(Depthcharge::RequestLogger).to have_received(:new).with(env, :a, :b, :c)
    end

    it "calls ReguestLogger#log" do
      logger = spy(:logger)
      allow(Depthcharge::RequestLogger).to receive(:new).and_return(logger)

      middleware.call(env)
      expect(logger).to have_received(:log)
    end
  end
end
