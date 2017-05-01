module Depthcharge
  module Formatters

    MAIN_INDENT = "  | "
    SUB_INDENT = "  "
    NEWLINE = "\n"

    def format_body(headers, body, level = 1)
      content_type = headers["Content-Type"]
      if content_type.include?("json")
        format_lines(JSON.pretty_generate(JSON.parse(body.join)), level)
      else
        format_lines(body.join, level)
      end
    end

    def format_hash(name, hash, level = 1)
      output = format_line(name.to_s.upcase + ":", level)

      hash.each do |key, value|
        output << format_line("#{key.to_s}: #{value.inspect}", level + 1)
      end

      output
    end

    def format_lines(lines, level = 1)
      lines = lines.split($/).map do |line|
        format_line(line, level)
      end

      lines.join
    end

    def blank_line(level = 1)
      format_line("", level)
    end

    def format_line(line, level = 1)
      indent(level) + line + NEWLINE
    end

    def indent(level)
      return "" if level == 0

      MAIN_INDENT + (SUB_INDENT * (level - 1))
    end

  end
end