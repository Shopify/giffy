require 'test_helper'
require 'giffy/processors/image_sequence_processor'

module Giffy
  module Processors
    class ImageSequenceProcessorTest < Minitest::Test
      include Giffy::Fixtures

      attr_reader :dir
      def setup
        @dir = images_directory_path
      end

      test "it collects the sequence based on the provided increment" do
        processor = ImageSequenceProcessor.new("increment" => 3)
        results = processor.process(dir)
        expected = %w(001.png 004.png 007.png).map { |e| "#{dir}/#{e}" }
        assert_equal expected.join(' '), results
      end

      test "it collects the sequence based on the default increment" do
        processor = ImageSequenceProcessor.new
        results = processor.process(dir)
        expected = %w(001.png 006.png).map { |e| "#{dir}/#{e}" }
        assert_equal expected.join(' '), results
      end
    end
  end
end
