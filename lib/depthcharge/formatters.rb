module Depthcharge
  module Formatters

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
      indent(level) + line + "\n"
    end

    def indent(level)
      return "" if level == 0

      main_indent = "  | "
      sub_indent = "  "

      main_indent + (sub_indent * (level - 1))
    end

  end
end