module Depthcharge
  class Middleware

    attr_reader :app, :outputs

    def initialize(app, *outputs)
      @app = app
      @outputs = outputs.flatten.map do |output|
        if output.is_a?(String) || output.is_a?(Pathname)
          File.open(output, "w")
        else
          output
        end
      end
    end

    def call(env)
      status, headers, body = @app.call(env)
      RequestLogger.new(env, status, headers, body).log(outputs)
      [status, headers, body]
    end
  end
end