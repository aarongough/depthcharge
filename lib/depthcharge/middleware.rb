module Depthcharge
  class Middleware

    attr_reader :app, :log_outputs

    def initialize(app, *log_outputs)
      @app = app
      @log_outputs = log_outputs
    end

    def call(env)
      status, headers, body = @app.call(env)
      RequestLogger.new(env, status, headers, body).log(log_outputs)
      [status, headers, body]
    end
  end
end