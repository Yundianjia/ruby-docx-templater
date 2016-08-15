require 'optparse'

module DocxTemplater
  class Command
    def initialize(args)
      @args    = args
      @options = {}
    end

    def run
      @opts = OptionParser.new(&method(:set_opts))
      @opts.parse!(@args)
      process!
      exit 0
    rescue Exception => ex
      raise ex if @options[:trace] || SystemExit === ex
      $stderr.print "#{ex.class}: " if ex.class != RuntimeError
      $stderr.puts ex.message
      $stderr.puts '  Use --trace for backtrace.'
      exit 1
    end

    def self.generate_doc(options = {})
      DocxTemplater.template_docx options
    end

    protected

    def process!
      args = @args.dup

      @options[:input]  = file        = args.shift
      @options[:output] = destination = args.shift

      @options[:input] = file = "-" unless file

      if File.directory?(@options[:input])
        Dir["#{@options[:input]}/**/*.#{format}"].each { |file| _process(file, destination) }
      else
        _process(file, destination)
      end
    end

    private

    def input_is_dir?
      File.directory? @options[:input]
    end

    def _process(file, destination = nil)
    end
  end
end