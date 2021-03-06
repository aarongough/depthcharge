require "spec_helper"

RSpec.describe Depthcharge::Formatters do

  include Depthcharge::Formatters

  let(:main_indent) { "  | " }
  let(:sub_indent) { "  " }
  let(:newline) { "\n" }

  describe "#blank_line" do
    it "returns a newline only when indent is zero" do
      expect(blank_line(0)).to eq(newline)
    end

    it "returns the main indent plus a newline when indent is not set" do
      expect(blank_line).to eq(main_indent + newline)
    end
  end

  describe "#format_line" do
    it "returns the input string and a newline when indent is zero" do
      expect(format_line("abc", 0)).to eq("abc" + newline)
    end

    context "with no explicit indent level" do
      it "returns the input string with main indent and newline added" do
        expect(format_line("abc")).to eq(main_indent + "abc" + newline)
      end
    end

    context "when indent level is set to 2" do
      it "returns the string with main indent, sub indent and newline added" do
        expect(format_line("abc", 2)).to eq(main_indent + sub_indent + "abc" + newline)
      end
    end
  end

  describe "#format_lines" do
    let(:lines) { "a\nb\nc\n" }

    it "returns the lines when indent level is zero" do
      expect(format_lines(lines, 0)).to eq(lines)
    end

    it "returns the lines with indent added" do
      expected_result = main_indent + "a\n" + main_indent + "b\n" + main_indent + "c\n"
      expect(format_lines(lines)).to eq(expected_result)
    end
  end

  describe "#format_hash" do
    let(:hash) { { a: "a", b: "b" } }

    it "returns the formatted hash with name" do
      result = format_hash(:name, hash).split("\n")

      expect(result[0]).to eq(main_indent + "NAME:")
      expect(result[1]).to eq(main_indent + sub_indent + 'a: "a"')
      expect(result[2]).to eq(main_indent + sub_indent + 'b: "b"')
    end
  end

  describe "#format_body" do
    context "when the content type is 'text/html'" do
      it "returns the body as-is" do
        expect(format_body({"Content-Type" => "text/html"}, ["Body"])).to eq("  | Body\n")
      end
    end

    context "when the content type is 'application/json'" do
      it "returns the JSON pretty formatted" do
        json_string = '{"a":{"b":"d"}}'

        expect(format_body({"Content-Type" => "application/json"}, [json_string])).to eq("  | {\n  |   \"a\": {\n  |     \"b\": \"d\"\n  |   }\n  | }\n")
      end
    end

    context "when given a rack response body" do
      it "renders the response" do
        expect {
          format_body({}, ["ABC"])
        }.not_to raise_error
      end
    end

    context "when given a rails response body" do
      it "renders the response" do
        expect {
          format_body({}, double("RackBody", body: "ABC"))
        }.not_to raise_error
      end
    end

    context "when the content type is not set" do
      it "does not raise an error" do
        expect {
          format_body({}, ["ABC"])
        }.not_to raise_error
      end
    end
  end
end
