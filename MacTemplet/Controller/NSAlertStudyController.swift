//
//  NSAlertStudyController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/29.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

/**
 1. 显示Alert 的标题文字
  messageText: String
  
 2. 提示详情文字
  informativeText: String
 
 3. 设置图片icon. 默认值是 NSApplicationIcon.
 icon: NSImage!
 
 4. 添加操作按钮的方法(添加的顺序是从右到左排列).
 func addButton(withTitle title: String) -> NSButton
 
 5. 获取所有的操作按钮(数组) : 最右边的按钮序号(index)为0
  buttons: [NSButton] { get }
 
 6. 是否显示帮助选项  (如果要使用帮助选项,需要设置(下面的属性:helpAnchor)的值)
  showsHelp: Bool
 
 7. 帮助的索引内容
  helpAnchor: String?
 
 8. NSAlert 样式 (级别):不同样式的级别不同
  alertStyle: NSAlertStyle
 
9 . 代理属性(用来响应帮助选项的事件)
  delegate: NSAlertDelegate?
10 . 是否显示一个可勾选的按钮选项提示
 showsSuppressionButton: Bool
 
11. 这个就是可勾选的按钮
 open var suppressionButton: NSButton? { get }
 
12. 添加自定义的辅助视图
accessoryView: NSView?
 
13 . NSAlert 立刻更新UI控件布局(默认情况下,NSAlert是在要显示的时候,才会开始布局UI)
func layout()
 
14. 已独立的窗口方式显示NSALert  : 根据这个方法的返回值,来确定用户的操作的选项
runModal() -> NSModalResponse
 
15. 已内嵌的方式显示NSAlert : 在闭包中获取用户操作的选项
beginSheetModal(for sheetWindow: NSWindow, completionHandler handler: ((NSModalResponse) -> Swift.Void)? = nil)
 
 16. 显示的window
 open var window: NSWindow { get }
 */


import Cocoa
import CocoaExpand
import SnapKit


enum IconSize: Int, CaseIterable {
    case twentyNine = 29
    case forty = 40
    case fiftyEight = 58
    case seventySix = 76
    case eighty = 80
    case eightySeven = 87
    case oneHundredAndTwenty = 120
    case oneHundredAndFiftyTwo = 152
    case oneHundredAndSixtySeven = 167
    case oneHundredAndEighty = 180
    case oneThousandAndTwentyFour = 1024
}

class NSAlertStudyController: NSViewController {

    private var sizesToReduce = IconSize.allCases

    lazy var stackView: NSStackView = {
        let view = NSStackView()
        view.orientation = .horizontal
//        view.distribution = .fillProportionally
        view.distribution = .fillEqually

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var stackView1: NSStackView = {
        let view = NSStackView()
        view.orientation = .horizontal
//        view.distribution = .fillProportionally
        view.distribution = .fillEqually

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(stackView)
        view.addSubview(stackView1)

        configCheckButtons()
        testStackView()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()

        stackView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(10);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.height.equalTo(60)
        }
        
        stackView1.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(200);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.height.equalTo(100)
        }
    }
    
    
    private func configCheckButtons() {
//        sizesToReduce.forEach { size in
//            let side = size.rawValue
////            let button = NSButton(checkboxWithTitle: "\(side)x\(side)", target: self, action: #selector(onClickCheckBox(_:)))
////            button.tag = size.rawValue
////            button.state = .on
//
//            let button = NSButton(radioButtonWithTitle: "\(side)x\(side)", target: self, action: #selector(onClickCheckBox(_:)))
//
//            stackView.addArrangedSubview(button)
//        }
        
        let titles = sizesToReduce.map { "\($0.rawValue)x\($0.rawValue)" }
        stackView.distributeViewsAlong(for: titles) { (idx, title) -> NSView in
            let button = NSButton(radioButtonWithTitle: "\(title)", target: self, action: #selector(self.onClickCheckBox(_:)))
            button.tag = idx
            return button
        }
        
//        stackView.distributeViewsAlongButton(for: .radio, titles: titles) { (sender) in
//            sender.addTarget(self, action: #selector(self.onClickCheckBox(_:)))
//        }
    }
    
    @objc func onClickCheckBox(_ sender: NSButton) {
        DDLog(sender.title, sender.state.rawValue, sender.tag)
        
        switch sender.tag {
        case 0:
            showAlert(sender)
        case 1:
            testStackView()
        default:
            showAlertOne()
        }
    }

    @objc func showAlert(_ sender: Any) {
        let alert = NSAlert()
        
        alert.messageText = "This is A Alert Demo Title"
        
        alert.informativeText = "this is a detail message about the title for alert"
        
//        alert.icon = NSImage(named: "alert")
        
        alert.addButton(withTitle: "按钮1")
        alert.addButton(withTitle: "按钮2")
        
        alert.showsSuppressionButton = true
        alert.suppressionButton?.title = "是否不再显示"
        alert.delegate = self
        alert.showsHelp = true
        alert.helpAnchor = "NSAlert"
        let imageView = NSImageView(frame: NSMakeRect(0, 0, 200, 100))
        imageView.image = NSImage(named: "alert")
        alert.accessoryView = imageView
        
        // 如果要修改accessoryView的位置,需要先调用layout方法
        alert.layout()
        
        imageView.frame = NSMakeRect(100, 0, 200, 100)
                
        // 显示NSAlert方式1: alert 内嵌在App的当前view的window中
        alert.beginSheetModal(for: view.window!) { (result) in
            // 根据suppressionButton?.state 获取用户是否选中勾选的项
            print(alert.suppressionButton?.state)  // on ,off
            
            switch result {
            case .alertFirstButtonReturn:
                print("点击了第一个按钮")

            case .alertSecondButtonReturn:
                    print("点击了第二个按钮")

            default:
                break
            }
            
        }
        // 显示方式2 : alert 单独的显示窗口
//        let result = alert.runModal()
//        if result == NSAlertFirstButtonReturn {
//            print("点击了第一个按钮")
//        }else if result == NSAlertSecondButtonReturn{
//            print("点击了第二个按钮")
//        }
        imageView.layer?.backgroundColor = NSColor.red.cgColor
    }
    
    
    func showAlertOne() {
        let nameField = NSTextField()
        nameField.placeholderString = "邮箱/手机号码"
        
        let pwdField = NSSecureTextField()
        pwdField.placeholderString = "6-20(数字字母组合)"
        
        let button = NSButton(radioButtonWithTitle: "button", target: self, action: #selector(self.onClickCheckBox(_:)))
        button.setButtonType(.onOff)
//        button.isHidden = true
        
        let stackView = NSStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        stackView.changeViews([nameField, pwdField, button], orientation: .vertical)
        
        let alert = NSAlert()
            .messageText("提示")
            .informativeText("非图片文件")
            .alertStyle(.warning)
            .addButtons(["确定", "取消",])
            .showsHelp(true)
            .showsSuppressionButton(true)
            .suppressionButtonAction({ (sender) in
                DDLog(sender.state.rawValue)
            })
            .delegate(self)
            .accessoryView(stackView)
            .beginSheet { (respone) in
                print("\(#function)\(respone)")
            }
        alert.window.initialFirstResponder = nameField
    }
    
    func testStackView() {
        let stackView = NSStackView(frame: CGRect(x: 20, y: 320, width: 300, height: 80))
        view.addSubview(stackView)
        stackView.layer?.backgroundColor = NSColor.systemGreen.cgColor
        
        
        let nameField = NSTextField()
        nameField.placeholderString = "邮箱/手机号码"
        
        let pwdField = NSSecureTextField()
        pwdField.placeholderString = "6-20(数字字母组合)"
        
        let button = NSButton(radioButtonWithTitle: "button", target: nil, action: nil)
        button.addActionHandler { (sender) in
            let orientation: NSUserInterfaceLayoutOrientation = sender.state.rawValue == 1 ? .vertical : .horizontal
            stackView.orientation = orientation
        }
        button.setButtonType(.onOff)
//        button.isHidden = true

        stackView.changeViews([nameField, pwdField, button], orientation: .horizontal)
        
//        stackView1.changeViews([nameField, pwdField, button], orientation: .horizontal)
//        stackView1.layer?.backgroundColor = NSColor.red.cgColor
    }
}

extension NSAlertStudyController : NSAlertDelegate{
    func alertShowHelp(_ alert: NSAlert) -> Bool {
        
        print("点击了帮助选项")
        // false : 表示代理未处理,系统采用默认方式处理帮助选项操作事件
        // true : 表示代理已处理帮助操作,系统不会再处理
        // 项目中,一般都会在这里进程跳转帮助的URL地址
        
        return true
    }
}



public extension NSStackView{

}
