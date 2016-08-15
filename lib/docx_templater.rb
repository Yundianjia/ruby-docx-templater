require 'docx_templater/version'
require 'docx_templater/template_processor'

module DocxTemplater
  module_function

  def log(str)
    # braindead logging
    puts str if ENV['DEBUG']
  end

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