{<img src#"https://travis-ci.org/jawspeak/ruby-docx-templater.png" />}[https://travis-ci.org/jawspeak/ruby-docx-templater]

# ruby-docx-templater

`ruby-docx-templater` 大体来说，就是将一个 `.docx` 文件用作模板， 然后，使用你的数据 创建一个新的 docx 文件


## 特性

* 所有操作都在内存中(尤其是有存在敏感数据时)
* 在 word 文件中，无论想要什么样的格式， 只要输入 `$KEY$`，就能实现全局的 key/value 替换。 
* 可以在 tables 插入多列循环， 并且，可以格式化成你想要的样式。 详细可以 `spec/example_input`。
* 计算文档列的总数 `#SUM:XYZ_LIST#`

##  Usage

* 在 word 中创建 template docx  
* 安装 rvm 和 bundler
* 运行 `bundle install`.
* 从模板中渲染出一个新的 docx 的文件， 例如: `ruby render_docx_template.rb`，然后，查看一个输出的 `output_*.docx` 文件。 
* Sample output with tests: `rake spec` (unit tests) `rake integration` (opens word)
* 通过测试查看样本输出: `rake spec`（单元测试）, `rake integration`(集成测试，打开 word)

__TECHNICAL NOTE:__ You will probably need to extract and edit the xml template manually after creating in Word, to prepare the ruby script template with it. This is very fiddly / hacky. You can’t have Word’s ugly markup around the fields to template. It will try to break up fields with markup. Test the template, fixing it until the extracted word/document.xml as needed.

__技术细节:__ 可能需要提取并且，在创建word时，手动编辑 xml template，然后，准备 ruby 脚本模板并对其进行模板化。 这非常的繁琐 且 hacky。 在 需要被模板化的字段周围，  不能有 word 的 肮脏的 markup 表示。 这些 markup 将会破坏 即将被模板化得域。 测试模板，知道可以提取出相应的 `word/document.xml` 文件。 


工作流：

1. 清楚工具区的所有的文件: `rm -rf word/`

2. 解压 样例模板的 docx 文件，到 `word/document.xml`

3. 然后编辑 `word/document.xml`

4. 使用 grep/search 搜索所有的 `$` 和 `#` 行, 然后，确保没有模板编辑 xml markup 文件。 然后，重新添加整个编辑的后的文档: 

  `zip ExampleTemplate.docx word/document.xml`
  
整体的思路就是一压缩的 xml 文件。  

__PRO TIP:__ 不能在替换的模板健那里有任何语法错误，否则他们将不会被替换。（语法替换）

## 开发

* 安装缺失的依赖，然后，运行测试用例集: `script/ci`
* 在安装了 word 的 mac 上, 运行测试： `rake spec`
* 构建 gem file: `gem build docx_templater.gemspec`

## 未来的想法

*  将来，使用 word 的 MailMerge 域，代替 自己的 `$KEY_ABC$`， 然后，就不必担心 word 会 在模板健域的文本中，插入莫名其妙的 XML 标记， 比如 #BEGIN_ROW:BLAH#。 这是个不错的注意, 并在添加域的时候，删除这些节点。

  ** 另外参考: {http://tomasvarsavsky.com/2009/04/04/simple-word-document-templating-using-ruby-and-xml/} and {https://github.com/bagilevi/docx_builder/tree/master/example/plan_report_template}**
* 此外，尽可能的，使用 Fields 值，来创建循结构。 这会避免 word 在文本的word 中，添加 markup。
* 从模板中渲染将会更加的优雅
* 尝试模板化 题首/题尾 
