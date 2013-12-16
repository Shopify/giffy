module Giffy
  module Processors
    class GifGenerationProcessor
      COMMANDS = {
        "delay" => '-delay',
        "other" => '-coalesce -layers OptimizeTransparency'
      }
      OPTIMIZE = '-fuzz 1%'
      DEFAULTS = {
        "filename" => 'animation.gif',
        "delay" => '1x10'
      }

      def initialize(options={})
        @optimize = options.delete("optimize")
        @opts = DEFAULTS.merge(options)
      end

      def command(filenames)
        result = %w(convert)
        result << OPTIMIZE if optimize?
        result << build_options(opts.merge("sequence" => filenames))
        result << opts["filename"]
        result.flatten.join(' ')
      end

      def process(filenames)
        Open3.popen3(command(filenames)) do |stdin, stdout, stderr, wait_thread|
          while line = stderr.gets
            puts line
          end
        end
        "Created #{opts["filename"]}"
      end

      private
      attr_reader :opts
      def build_options(options)
        COMMANDS.sort.map do |key, command|
          value = options[key]
          value = send(key, value, options) if respond_to?(key, true)
          value ? [command, value] : [command]
        end
      end

      def optimize?
        @optimize
      end

      def delay(amount, options)
        "#{amount} #{options["sequence"]}"
      end
    end
  end
end
