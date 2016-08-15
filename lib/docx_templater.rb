require 'docx_templater/version'
require 'docx_templater/template_processor'
require 'docx_templater/docx_creator'

module DocxTemplater
  module_function

  def log(str)
    # braindead logging
    puts str if ENV['DEBUG']
  end

  # template docx file
  #
  # @param {Hash} options -
  #
  # @example
  #   options = {
  #     input_file: 'xxx',
  #     output_file: 'xxx',
  #     data: { key: value }
  #   }
  def template_docx(options = {})
    puts "options: #{options}"

    DocxTemplater::DocxCreator.new(options[:input_file], options[:data]).generate_docx_file(options[:output_file])

    archive = Zip::File.open(options[:output_file])
    archive.close

    DocxTemplater.open_output_file options[:output_file]
  end


  # Open word file in mac os(with word installed)
  def open_output_file(output_file)
    puts "\n************************************"
    puts '   >>> Only will work on mac <<<'
    puts 'NOW attempting to open created file in Word.'
    cmd = "open #{output_file}"
    puts "  will run '#{cmd}'"
    puts '************************************'

    system cmd
  end
end

Gem.find_files('docx_templater/*.rb').each { |path| require path }