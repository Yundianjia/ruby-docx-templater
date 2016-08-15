# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'docx_templater/version'

Gem::Specification.new do |s|
  s.name = 'template_docx'
  s.version = DocxTemplater::VERSION
  s.authors = ['Jonathan Andrew Wolter', 'xiajian']
  s.email = ['jaw@jawspeak.com', 'jhqy2011@gmail.com']
  s.description = 'A Ruby library to template Microsoft Word .docx files. Uses a .docx file with keyword tags within "$$" as a template. '
  s.summary = 'Generates new Word .docx files based on a template file.'
  s.homepage = 'https://github.com/Yundianjia/ruby-docx-templater'
  
  s.require_paths = ['lib']
  root_files = %w(docx_templater.gemspec LICENSE.txt Rakefile README.md .gitignore Gemfile)
  s.files = Dir['{lib,script,spec,bin}/**/*'] + root_files
  s.test_files = Dir['spec/**/*']

  s.add_runtime_dependency('nokogiri')
  s.add_runtime_dependency('rubyzip', '>= 1.1.1')

  s.add_development_dependency('rake')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rspec')
end