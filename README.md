{<img src#"https://travis-ci.org/jawspeak/ruby-docx-templater.png" />}[https://travis-ci.org/jawspeak/ruby-docx-templater]


# Roughly, this takes a .docx file and uses it as a template to create a new docx, with your data

## Features

* All manipulation in memory (great if you have sensitive data)
* Global key/value substitutions by entering a `$KEY$` anywhere in the word document, with whatever formatting you want.
* Multi-row loops inside tables, also with whatever your formatting you wish. `#BEGIN_ROW:XYZ#`... `#END_ROW:XYZ#` see tests/example
* Summation formula for row count `#SUM:XYZ_LIST#`

## Usage

* Create your docx "template" in Word
* Install rvm and bundler
* Run `bundle install`.
* Render new docx files from the template, ex: `ruby render_docx_template.rb`. Look for an output_*.docx file.
* Sample output with tests: `rake spec` (unit tests) `rake integration` (opens word)

__TECHNICAL NOTE:__ You will probably need to extract and edit the xml template manually after creating in Word, to prepare the ruby script template with it. This is very fiddly / hacky. You can’t have Word’s ugly markup around the fields to template. It will try to break up fields with markup. Test the template, fixing it until the extracted word/document.xml as needed.

I frequently use this workflow:
`rm -rf word/;   unzip ExampleTemplate.docx  word/document.xml;   mate word/document.xml`
Grep/search for all $ and # lines and ensure no templating is split with xml markup.
And then re-add the edited document:
`zip ExampleTemplate.docx word/document.xml`

__PRO TIP:__ You don’t want any grammar errors on the template Keys, or they will not substitute. (Grammar suggestion markup splits up the tokens in the xml). Right click and choose Ignore each grammar error.

[中文文档](https://github.com/Yundianjia/ruby-docx-templater/blob/master/README_cn.md)


## Development

* Install any missing dependencies, then run the test suite: `script/ci`
* Run the integration test suite (on mac, with word installed): `rake integration`
* Build the gem file: `gem build docx_templater.gemspec`


## Future ideas

* We could in the future use Word's MailMerge fields instead of using our own style `$KEY_ABC$` keys. We would then not have to worry about Word munging our text by inserting XML markup in-between parts of a template key #BEGIN_ROW:BLAH#. This is probably a really good idea. Also we would need to delete these other nodes that get added when Fields are added.
** See also: {http://tomasvarsavsky.com/2009/04/04/simple-word-document-templating-using-ruby-and-xml/} and {https://github.com/bagilevi/docx_builder/tree/master/example/plan_report_template},
* Possibly, also use Fields to create the looping constructs. That would be a big win for preventing word adding markup between words in by text.
* Make rendering from the template more efficient.
* Try templating header/footer (I haven't attempted that yet because I do not have a need for it.)
