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

    def log(*outputs)
      log_entry = construct_log_entry

      outputs.flatten.each do |output|
        output.puts(log_entry)
        output.flush
      end
    end

    def construct_log_entry
      output = ""
      output << blank_line(0)
      output << format_line("#{env["REQUEST_METHOD"]} #{status} #{env["PATH_INFO"].inspect} at #{Time.now}", 0)
      output << format_hash("PARAMS", request_params(env))
      output << blank_line
      output << format_hash("REQUEST HEADERS", request_headers(env))
      output << blank_line
      output << format_line("RESPONSE STATUS: #{status}")
      output << blank_line
      output << format_hash("RESPONSE HEADERS", headers)
      output << blank_line
      output << format_line("BODY:")
      output << format_body(headers, body, 2)
      output << blank_line
      output << blank_line(0)
    end

  end
end