# 配置
## 设置字符集
- FILE -> SETTINGS -> FILE ENCODINGS -> IDE ENCODING
- FILE -> SETTINGS -> FILE ENCODINGS -> DEFAULT ENCODING FOR PROPERTIES FILES
- FILE -> SETTINGS -> COMPILER -> JAVA COMPILER -> ADDITIONAL COMMAND LINE PARAMETERS
- FILE -> Other Settings -> Default Settings -> Editor -> FILE Encodings ：设置默认的文件编码方式，所有新建的工程使用的都是默认的文件编码方式。

加上参数 -ENCODING UTF-8 编译GROOVY文件的时候如果不加，STRING S = "中文"; 这样的GROOVY文件编译不过去.

## 显示行号 
Settings->Editor->General->Appearance标签项，勾选Show line numbers

## 生成serialVersionUID
默认情况下Intellij IDEA是关闭了继承了java.io.Serializable的类生成serialVersionUID的警告。如果需要ide提示生成serialVersionUID，那么需要做以下设置：
- setting->Inspections->Serialization issues，将serialzable class without "serialVersionUID"打上勾；
- 将光标放到类名上，按atl＋enter键{使用不同的keymap可能快捷键不同}，就会提示生成serialVersionUID了。

# 插件
## CamelCase
转换下划线、大写、小写、驼峰命名方式
Switch easily between CamelCase, camelCase, snake_case and SNAKE_CASE. See Edit menu or use SHIFT + ALT + U.

## Translation
翻译插件，alt+1触发，需要在有道翻译注册应用ID及密钥
3e36216a180be53b
ibEtw9IsNG7vqKtyWykJTNdq4QEA01i3

## GsonFormat
从JSON字符串生成JAVA类