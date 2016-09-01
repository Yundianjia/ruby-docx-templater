<a href='https://travis-ci.org/jawspeak/ruby-docx-templater'>
  <img src="https://travis-ci.org/jawspeak/ruby-docx-templater.png" />
</a>

# ruby-docx-templater 

Roughly, this takes a .docx file and uses it as a template to create a new docx, with your data

## Installation
   
Add this line to your application's Gemfile:


```ruby
gem 'template_docx'
```

Or, 


```ruby
gem 'template_docx', github: 'xiajian/ruby-docx-templater'
```

And then execute:

   $ bundle

Or install it yourself as:

   $ gem install template_docx


## Usage

[中文文档](https://github.com/Yundianjia/ruby-docx-templater/blob/master/README_cn.md)

### Command Line: 

Base Usage

```
Usage: docx-templater [options]
    -i, --input-file [file]          Default: Example.docx
    -d, --format-data [data]         Default: data format file, json format - Not Implementation, No Used!!
    -o, --output-file [file]         Default: OutputTemplate.docx
    -h, --help                       Show this message
    -v, --version                    Print version
```

Usage example:  `docx-templater -i -d tmp/test.json -o`  or  `docx-templater -i -d tmp/test.json -o`

Example yml file: 

```
---
:company: 伟大的邪王真眼
:shop_name: 斜阳西下，三百二十七
:shop_id: 122323232323
:shop_url: http://blog.csdn.net/ruixj/article/details/3765385
:master_company: 紫电清爽公司
:brand_name: 邪王正眼
:start_date: 2016年-08月-31日
:end_date: 2016年-09月-01日
:license_number: 1212121212
:authorized_party: 夏健的夏天
:authorized_date: 2016年-09月-01日
```

Example json file: 


```
{
  "company": "伟大的邪王真眼",
  "shop_name": "斜阳西下，三百二十七",
  "shop_id": 122323232323,
  "shop_url": "http://blog.csdn.net/ruixj/article/details/3765385",
  "master_company": "紫电清爽公司",
  "brand_name": "邪王正眼",
  "start_date": "2016年-08月-31日",
  "end_date": "2016年-09月-01日",
  "license_number": 1212121212,
  "authorized_party": "夏健的夏天",
  "authorized_date": "2016年-09月-01日"
}
```

Programming: 

```
options = {
  input_file: 'spec/example_input/ExampleBrand.docx'
  output_file: 'OutputTemplate.docx',
  data = {
    company: '伟大的邪王真眼',
    shop_name: '斜阳西下，三百二十七',
    shop_id: 122323232323,
    shop_url: 'http://blog.csdn.net/ruixj/article/details/3765385',
    master_company: '紫电清爽公司',
    brand_name: '邪王正眼',
    start_date: (Time.now - 3600 * 24).strftime('%Y年-%m月-%d日'),
    end_date: Time.now.strftime('%Y年-%m月-%d日'),
    license_number: 1212121212,
    authorized_party: '夏健的夏天',
    authorized_date: Time.now.strftime('%Y年-%m月-%d日') 
  }
}

DocxTemplater.template_docx options
```

### workflow

* Create your docx "template" in Word
* Install rvm and bundler
* Run `bundle install`.
* Render new docx files from the template, ex: `ruby render_docx_template.rb`. Look for an output_*.docx file.
* Sample output with tests: `rake spec` (unit tests) `rake integration` (opens word)

__TECHNICAL NOTE:__ You will probably need to extract and edit the xml template manually after creating in Word, to prepare the ruby script template with it. This is very fiddly / hacky. You can’t have Word’s ugly markup around the fields to template. It will try to break up fields with markup. Test the template, fixing it until the extracted word/document.xml as needed.

**Workflow**:

1. remove word directory file: `rm -rf word/`

2. unzip example template docx: `unzip ExampleTemplate.docx word/document.xml`

3. edit xml: `vi word/document.xml`

4. Grep/search for all $ and # lines and ensure no templating is split with xml markup.
And then re-add the edited document: `zip ExampleTemplate.docx word/document.xml`

__PRO TIP:__ You don’t want any grammar errors on the template Keys, or they will not substitute. (Grammar suggestion markup splits up the tokens in the xml). Right click and choose Ignore each grammar error.


## Development

* Install any missing dependencies, then run the test suite: `script/ci`
* Run the integration test suite (on mac, with word installed): `rake integration`
* Build the gem file: `gem build docx_templater.gemspec`

## Features

* All manipulation in memory (great if you have sensitive data)
* Global key/value substitutions by entering a `$KEY$` anywhere in the word document, with whatever formatting you want.
* Multi-row loops inside tables, also with whatever your formatting you wish. `#BEGIN_ROW:XYZ#`... `#END_ROW:XYZ#` see tests/example
* Summation formula for row count `#SUM:XYZ_LIST#`


## Future ideas

* We could in the future use Word's MailMerge fields instead of using our own style `$KEY_ABC$` keys. We would then not have to worry about Word munging our text by inserting XML markup in-between parts of a template key #BEGIN_ROW:BLAH#. This is probably a really good idea. Also we would need to delete these other nodes that get added when Fields are added.
** See also: {http://tomasvarsavsky.com/2009/04/04/simple-word-document-templating-using-ruby-and-xml/} and {https://github.com/bagilevi/docx_builder/tree/master/example/plan_report_template},
* Possibly, also use Fields to create the looping constructs. That would be a big win for preventing word adding markup between words in by text.
* Make rendering from the template more efficient.
* Try templating header/footer (I haven't attempted that yet because I do not have a need for it.)