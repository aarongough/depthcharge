module Depthcharge
  class RequestLogger

    include Formatters
    include Filters

    attr_reader :env, :status, :headers, :body

    def initialize(env, status, headers, body)
      @env = env
      @status = status
      @headers = headers
      @body = body
    end

    def log
      output = ""
      output << format_line("#{env["REQUEST_METHOD"]} #{env["PATH_INFO"].inspect} at #{Time.now}", 0)
      output << format_hash("params", request_params(env))
      output << blank_line
      output << format_hash("request headers", request_headers(env))
      output << blank_line
      output << format_hash("response headers", headers)
      output << blank_line

      puts output
    end

  end
end