module Giffy
  module Processors
    class ImageSequenceProcessor
      DEFAULT_INCREMENT = 5
      attr_reader :increment
      def initialize(options={})
        @increment = options[:increment] || DEFAULT_INCREMENT
      end

      def process(dir)
        accumulator = []
        entries = Dir.entries(dir).reject { |entry| (entry =~ /\.png\z/) == nil }
        entries.each_with_index do |entry, index|
          accumulator << entry if index % increment == 0
        end
        accumulator
      end
    end
  end
end
