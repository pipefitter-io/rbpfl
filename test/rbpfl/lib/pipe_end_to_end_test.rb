require_relative "../../test_helper"

class FileReader < Rbpfl::Source
  def initialize(filepath)
    @filepath = filepath
  end

  protected

  def produce
    content = File.read(@filepath)
    Rbpfl::Message.new(:txt_file, content)
  end
end

class RetractionFilter < Rbpfl::Filter
  protected

  def filter_criteria(message)
    # Directly modify the message's payload to remove "Unneeded data"
    #
    # There are two main filter types:
    #   - Types that retract data, thus mutating it.
    #   - Types that reject the whole message entirely.
    #
    # This is an example of the a 'retracting' filter.
    #
    retracted_payload = message.payload.gsub("Unneeded data", "")

    # Return a new message with the retracted payload, keeping the original message type.
    Rbpfl::Message.new(message.protocol, retracted_payload)
  end
end

class WidgetTxtToJson < Rbpfl::Transformer
  protected

  def transform_item(message)
    json_content = {content: message.payload}.to_json
    Rbpfl::Message.new(:json, json_content)
  end
end

class FileWriter < Rbpfl::Sink
  def initialize(filepath)
    @filepath = filepath
  end

  protected

  def consume_item(message)
    File.write(@filepath, message.payload)
  end
end

class TestPipeEndToEnd < Minitest::Test
  def setup
    @input_path = "test/fixtures/input.txt"
    @output_path = "test/fixtures/output.json"
    @expected_content = {content: "This is a test.\n"}.to_json

    FileUtils.mkdir_p(File.dirname(@input_path))
    File.write(@input_path, "This is a test.\nUnneeded data")
  end

  def teardown
    File.delete(@input_path) if File.exist?(@input_path)
    File.delete(@output_path) if File.exist?(@output_path)
  end

  def test_processes_text_file_through_stages_and_produces_filtered_json_output
    pipe = Rbpfl::Pipe.new
    pipe.add_stage(FileReader.new(@input_path))
    pipe.add_stage(RetractionFilter.new)
    pipe.add_stage(WidgetTxtToJson.new)
    pipe.add_stage(FileWriter.new(@output_path))

    pipe.execute

    assert(File.exist?(@output_path), "Output file does not exist")
    assert_equal(@expected_content, File.read(@output_path), "File content does not match expected content")
  end
end
