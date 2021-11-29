//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/22.
//

import UIKit

class NoteEditVC: UIViewController {

    var photos = [UIImage(named: "house_icon_group")!,UIImage(named:"house_icon_group")!, UIImage(named:"house_icon_group")!, UIImage(named: "house_icon_group")!]
    @IBOutlet weak var photoCollectView: UICollectionView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var photoCount :Int { photos.count }
    //var videopath:URL = Bundle.main.url(forResource: "1637763333941326", withExtension: "mp4")! 测试地址
    var videopath:URL?
    var isVideo:Bool{ videopath != nil}
    var textaccessView:InputAccessoryView {textView.inputAccessoryView as! InputAccessoryView}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confing()
    }
    
    @IBAction func TFEditBgin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }

    @IBAction func TFEditChange(_ sender: Any) {
        // MARK: - 使用搜狗拼音的时候使用 注意防止粘贴的时候有空格可以在storyboard 中设置Smart Insert 属性为NO
        guard titleTF.markedTextRange == nil else{ return}//处于高亮编辑状态的时候不进行计数
        if titleTF.unwrapedText.count > KMaxNotetitleCount {
            titleTF.text = String(titleTF.unwrapedText.prefix(KMaxNotetitleCount)) //截取前面KMaxNotetitleCount个数
            showTextHUD("标题最多输入\(KMaxNotetitleCount)字哦!")
            //处理光标的位置 需要放在主线程中
            DispatchQueue.main.async{
                let end = self.titleTF.endOfDocument //获取文本光标最后的位置
                self.titleTF.selectedTextRange = self.titleTF.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(KMaxNotetitleCount - titleTF.unwrapedText.count)"
    }
    //    //第二种键盘收齐方式这个方式只需要实现方式类型为didEndonExit 代理方法就可以
    @IBAction func TFEdiExit(_ sender: Any) {
    }
    
    func confing(){
        // MARK: - ##拉升优先级越高的元素不会被拉升:既hugging这个值越大就不会被拉升 (例如左边的textfield 右边一个lable textfield的hugging默认会高于lable textfield就会被拉升) 压缩优先级 越高的元素不会被压缩:既coppress这个值越大就不会被压缩(例如左边的textfield 右边一个lable 当textfield的内容超过自身大小的时如果lable的coppress值小于textfield的coppress会被压缩)
        
        photoCollectView.dragInteractionEnabled = true
        // Do any additional setup after loading the view.
        //第三种收起软键盘的方式通过给view添加手势
        hideKeyboardWhenTapeedAroun()
        titleCountLabel.text = "\(KMaxNotetitleCount)"
        
        
        // MARK: -注意如果UITextField有board的时候会有一定距离
        // MARK: -注意如果UITextView距离上下8的距离 左右有缩进5的(textView.textContainer.lineFragmentPadding系统默认=5)距离一定距离  textView.textContainer.lineFragmentPadding//表示左右文本缩进默认为5
        textView.textContainerInset = UIEdgeInsets(top:0, left:0, bottom:0, right:0)//设备文本边距为0
        textView.textContainer.lineFragmentPadding = 0//设置文本内容边距为0
        
          // MARK: - 修改行间距
        let paragraphStyle = NSMutableParagraphStyle()
        //paragraphStyle.lineHeightMultiple = 2 //  设置的是文本的高度这个高度会改变光标的高度
        paragraphStyle.lineSpacing = 6 //设置的事行间距
        textView.typingAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel]
        //修改光标的颜色需要修改tineColor   在调用tintColorDidChange
        textView.tintColor = UIColor(named: "main")!//颜色
        textView.tintColorDidChange()
        
        textView.inputAccessoryView = Bundle.loadView(fromNib: "InputAccessoryView", with: InputAccessoryView.self)
        textaccessView.doneBtn.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        textaccessView.maxTextCountLabel.text = "/\(KMaxNoteTextCount)"
        //        if let inputAccessoryView = Bundle.main.loadNibNamed("InputAccessoryView", owner: nil, options: nil)?.first as? InputAccessoryView {
        //            textView.inputAccessoryView = inputAccessoryView
        //            textaccessView.doneBtn.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        //            textaccessView.maxTextCountLabel.text = "/\(KMaxNoteTextCount)"
        //        }
    }

    @objc override func dismissKeyboard(){
        
        textView.resignFirstResponder()
    }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
//  // MARK: - 没有使用搜狗拼音的时候可以使用
//extension NoteEditVC:UITextFieldDelegate {
//      // MARK: - 第一种UITextFieldD收齐软键盘
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
////        titleTF.resignFirstResponder()
////        return true
////    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let  isExced = (range.location >= KMaxNotetitleCount || (string.count + textField.unwrapedText.count) > KMaxNotetitleCount)
//        if isExced{
//            showTextHUD("标题最多输入\(KMaxNotetitleCount)字哦!")
//        }
//        return !isExced
//    }
//
extension NoteEditVC:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // MARK: - 使用搜狗拼音的时候使用 注意防止粘贴的时候有空格可以在storyboard 中设置Smart Insert 属性为NO
        guard textView.markedTextRange == nil else{ return}//处于高亮编辑状态的时候不进行计数
        textaccessView.currentCount = textView.text.count
    }
}
