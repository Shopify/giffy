require 'test_helper'
require 'giffy/pipeline'

module Giffy
  class PipelineTest < Minitest::Test
    class Processor
      def initialize(*args)
      end
    end

    class Yeller < Processor
      def process(input)
        input.upcase
      end
    end

    class Reverser < Processor
      def process(input)
        input.reverse
      end
    end

    attr_reader :pipeline
    def setup
      @pipeline = Pipeline.new([Yeller, Reverser])
    end

    test "running something through the pipeline" do
      assert_equal "DLROW OLLEH", pipeline.process("hello world", {})
    end
  end
end
