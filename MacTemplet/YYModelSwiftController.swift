//
//  YYModelSwiftController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit
import SnapKitExtend

class YYModelSwiftController: NSViewController {
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        view.delegate = self
        return view;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["UIViewController列表", "自定义视图", "API文件", ]
        return view;
    }()

    lazy var comboBox: NSComboBox = {
        let view = NSComboBox(frame: .zero)
        view.addItems(withObjectValues: ["菜单一", "菜单二", "菜单三", ])
//        view.usesDataSource = true
//        view.dataSource = self
//        view.delegate = self
  
        return view;
    }()
    
//    lazy var btn: NSButton = {
//        let view = NSButton(title: "Done", target: nil, action: nil)
//        view.setButtonType(.momentaryPushIn)
//        view.bezelStyle = .shadowlessSquare
////        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
//        view.addActionHandler { (control) in
//            NSApp.mainWindow?.makeFirstResponder(nil)
//            self.createFile(self.textView.string)
//
//        }
//        return view;
//    }()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        title = "iOS类文件批量生成"
        view.addSubview(comboBox)
        view.addSubview(segmentCtl)
        view.addSubview(textView.enclosingScrollView!)
        
        comboBox.isHidden = true
        segmentCtl.isHidden = true
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                
        comboBox.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        let width = CGFloat(segmentCtl.items.count)*120
        segmentCtl.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(width)
        }
        
        textView.enclosingScrollView!.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalTo(comboBox.snp.top).offset(-10)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        

        let path = Bundle.main.path(forResource: "appinfo", ofType: "txt")
        let content = try? String(contentsOfFile: path!, encoding: .utf8)
        self.textView.string = content!
        
        guard let dic: [String: Any] = JSONSerialization.ObjFromGeojson("Json1.geojson") as? [String : Any] else { return }
//        let model = NNRootModel.yy_model(with: dic)
        let model = NNHouseRootModel.yy_model(with: dic)
        
        guard let list: [Any] = JSONSerialization.ObjFromGeojson("blocks.geojson") as? [Any] else { return }
        let modelArray = NSArray.yy_modelArray(with: NNBlocksModel.self, json: list)

        let dataModel: NNBlocksModel = modelArray?.first as! NNBlocksModel
        DDLog(model)
        DDLog(modelArray)
        DDLog(dataModel.yy_modelDescription())

    }
    
    // MARK: -funcitons
    /// 批量创建文件
    func createFile(_ string: String) {

    }
    /// 按照类型创建文件


}

extension YYModelSwiftController: NSTextViewDelegate {

    func textShouldBeginEditing(_ textObject: NSText) -> Bool{
        return true
    }

    func textShouldEndEditing(_ textObject: NSText) -> Bool {
        return true
    }
    
    func textDidBeginEditing(_ notification: Notification){
        
    }

    func textDidEndEditing(_ notification: Notification){
        
    }

    func textDidChange(_ notification: Notification) {
        if textView.string.count <= 0 {
            return
        }
        createFile(textView.string)
    }
}


extension YYModelSwiftController: NSComboBoxDataSource, NSComboBoxDelegate{

    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return comboBox.numberOfItems
    }

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return comboBox.itemObjectValue(at: index)
    }

    func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
        return comboBox.indexOfItem(withObjectValue: string)
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {

        let comBox = notification.object as! NSComboBox

        let selectedIndex = comBox.indexOfSelectedItem

        let selectedContent = comBox.stringValue

        print("selectedIndex = \(selectedIndex) selectedContent = \(selectedContent)")

    }

}
