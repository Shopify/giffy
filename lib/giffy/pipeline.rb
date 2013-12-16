module Giffy
  class Pipeline
    attr_reader :processors
    def initialize(processors)
      @processors = processors
    end

    def process(input, options)
      processors.reduce(input) do |input, processor|
        instance = processor.new(options)
        instance.process(input)
      end
    end
  end
end
