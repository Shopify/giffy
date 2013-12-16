require 'open3'

module Giffy
  module Processors
    class VideoExtractionProcessor
      COMMANDS = {
        format: '-f',
        input: '-i',
        length: '-t',
        size: '-s',
        start: '-ss'
      }

      DEFAULTS = {
        size: '1024x768'
      }

      attr_reader :dir
      def initialize(options={})
        @dir = options.fetch(:dir) { |key| Dir.mktmpdir }
        @opts = DEFAULTS.merge(options)
      end

      def command(input)
        result = %w(ffmpeg) + build_options(opts.merge(input: input))
        result.flatten.join(' ')
      end

      def process(input)
        Open3.popen3(command(input)) do |stdin, stdout, stderr, wait_thread|
          while line = stderr.gets
            puts line
          end
        end
        dir
      end

      private
      attr_reader :opts
      def build_options(options)
        results = COMMANDS.sort.map do |key, command|
          value = options[key]
          value = send(key, value) if respond_to?(key, true)
          value ? [command, value] : []
        end
        results
      end

      def format(value=nil)
        "image2 #{dir}/%03d.png"
      end

    end
  end
end
