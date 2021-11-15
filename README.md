#一本地化/国际化: 
##1 app名称国际化 
##2 代码中 内容文本的国际化(创建方式一:newfile选择Resource 中的string File 名称为Localizable.strings   创建方式二:命令行进入到项目中LittlePink 文件的文件夹下面 使用命令genstrings -o zh-Hans.lproj *.swift    如果么有就输出到指定的文件夹中 genstrings -o zh-Hans.lproj  XXX/*.swift 
##3 app图片的国际化 方式一:在Assets文件中选择要国际化的图片 在选中右上角最后一个栏目在最下面Localization中选择要国际化的语言在添加对应的国际化图片 方式二;使用 NSlocalizedSreing("") 的命名方式去匹配不同图片的在国际化Localizable文件的key
##4 storyboard中的文本国际化(需要选中storyboard 在右边工具栏目中locaization 添加需要的语言他会自动给需要的空间生成一个标签id)
## app系统文字的国际化 选择Xcode左上角的项目 选中project 在info栏目下选择 Locanlization添加需要的语言他会在我们mainstoryboard下面生成一个系统的语言文件

