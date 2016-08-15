require 'spec_helper'
require 'template_processor_spec'

describe 'integration test', integration: true do
  let(:data) { DocxTemplater::TestData::DATA }
  let(:base_path) { SPEC_BASE_PATH.join('example_input') }
  let(:input_file) { "#{base_path}/ExampleTemplate.docx" }
  let(:output_dir) { "#{base_path}/tmp" }
  let(:output_file) { "#{output_dir}/IntegrationTestOutput.docx" }

  let(:brand_data) { DocxTemplater::BrandData::DATA }
  let(:brand_input_file) { "#{base_path}/ExampleBrand.docx" }
  let(:brand_output_file) { "#{output_dir}/IntegrationBrandOutput.docx" }

  before do
    FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
    Dir.mkdir(output_dir)
  end

  context 'should process in incoming docx' do

    def handle_output_file(output_file)
      puts "\n************************************"
      puts '   >>> Only will work on mac <<<'
      puts 'NOW attempting to open created file in Word.'
      cmd = "open #{output_file}"
      puts "  will run '#{cmd}'"
      puts '************************************'

      system cmd
    end

    # TODO: 这两个生成 DOC 文件的 测试用例，不能同时执行
    it 'generates a valid zip file (.docx)' do
      DocxTemplater::DocxCreator.new(input_file, data).generate_docx_file(output_file)

      archive = Zip::File.open(output_file)
      archive.close

      handle_output_file output_file
    end

    it 'generates a valid doc file with brand data' do
      DocxTemplater::DocxCreator.new(brand_input_file, brand_data).generate_docx_file(brand_output_file)

      archive = Zip::File.open(brand_output_file)
      archive.close

      handle_output_file brand_output_file
    end

    it 'generates a file with the same contents as the input docx' do
      input_entries = Zip::File.open(input_file) { |z| z.map(&:name) }
      DocxTemplater::DocxCreator.new(input_file, data).generate_docx_file(output_file)
      output_entries = Zip::File.open(output_file) { |z| z.map(&:name) }

      expect(input_entries).to eq(output_entries)
    end
  end
end
