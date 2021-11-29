#一本地化/国际化: 
##1 app名称国际化 
##2 代码中 内容文本的国际化(创建方式一:newfile选择Resource 中的string File 名称为Localizable.strings   创建方式二:命令行进入到项目中LittlePink 文件的文件夹下面 使用命令genstrings -o zh-Hans.lproj *.swift    如果么有就输出到指定的文件夹中 genstrings -o zh-Hans.lproj  XXX/*.swift 
##3 app图片的国际化 方式一:在Assets文件中选择要国际化的图片 在选中右上角最后一个栏目在最下面Localization中选择要国际化的语言在添加对应的国际化图片 方式二;使用 NSlocalizedSreing("") 的命名方式去匹配不同图片的在国际化Localizable文件的key
##4 storyboard中的文本国际化(需要选中storyboard 在右边工具栏目中locaization 添加需要的语言他会自动给需要的空间生成一个标签id)
##5 app系统文字的国际化 选择Xcode左上角的项目 选中project 在info栏目下选择 Locanlization添加需要的语言他会在我们mainstoryboard下面生成一个系统的语言文件

# swift中使用oc包方法
##1情况一:直接使用oc的第三方库时pod进来后需要在 创建Bridging Heard文件取名最好是"项目名称-Bridging-Header" 然后再tagart的setting中搜索brid在Objective-C Bridging Heard中 输入"项目名称/项目名称-Bridging-Header.h"
##情况二:如果是直接创建oc文件会直接自动弹出让用户创建上面的文件不用在setting中在去设置

##拉升优先级越高的元素不会被拉升:既hugging这个值越大就不会被拉升 (例如左边的textfield 右边一个lable textfield的hugging默认会高于lable textfield就会被拉升)
##压缩优先级 越高的元素不会被压缩:既coppress这个值越大就不会被压缩(例如左边的textfield 右边一个lable 当textfield的内容超过自身大小的时如果lable的coppress值小于textfield的coppress会被压缩)
##textView 只读状态不能修改行间距 如果想修改行高需要设置他的富文本 既:typingAttributes属性
