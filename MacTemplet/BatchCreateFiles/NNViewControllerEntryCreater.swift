//
//  NNViewControllerEntryCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


class NNViewControllerEntryCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
import UIKit

/// 创建
@objcMembers class \(prefix)Controller: UIViewController {

    var model = NSObject(){
        willSet{
        
        }
    }

    var dataModel = NSObject()
    
    lazy var viewModel = \(prefix)ViewModel()

//    var isValidateParams: Bool {
//        viewModel.etcFilesAPI.dataModel = dataModel;
//        let isValid = viewModel.etcFilesAPI.validateParamsOne()
//        return isValid
//    }
    
    lazy var list: [[[String]]] = {
        var array: [[[String]]] = [
            [["[移动端仅支持PDF格式]", "UITableViewCellTitle", "50.0", "", "",],
            ["*ETC开通协议" + kBlankThree, "UITableViewCell", "50.0", "查看,上传", "etc_protocol_link", ],
            ["*项目报备单" + kBlankOne, "UITableViewCell", "50.0", "查看,上传", "etc_project_report", ],
            ["*密钥卡申领单" + kBlankOne, "UITableViewCell", "50.0", "查看,上传", "etc_key_request_form", ],
            ],
            [["*收件人" + kBlankThree, "UITableViewCellTextField", "50.0", "请输入名称", "equipment_receiver", ],
            ["*联系方式" + kBlankTwo, "UITableViewCellTextField", "50.0", "请输入手机号码", "contact_phone", ],
            ["*收件地址" + kBlankTwo, "UITableViewCellTextField", "50.0", "请输入收件地址", "receiver_address", ],
            ],
        ]
        return array
    }()
    
    lazy var rightBtn: UIButton = {
        let view = UIButton.create(title: "Next", textColor: .white, backgroundColor: .theme)
        view.addActionHandler({ (control) in
//            let controller = UIViewController()
//            self.navigationController?.pushViewController(controller, animated: true)
            
        }, for: .touchUpInside)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
        view.dataSource = self
        view.delegate = self

        return view
    }()
    
    lazy var footerView: NNTableFooterView = {
        let view = NNTableFooterView.create("提交", topPadding: 30);
        view.btn.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return view
    }()
    
    @objc func handleAction(_ sender: UIButton) {
        view.endEditing(true)
//        DDLog(sender.currentTitle)
//        if isValidateParams == false {
//            return
//        }
        requestAdd()
    }
    
//    lazy var uploadImageVC: IOPUploadImageController = {
//        let controller = IOPUploadImageController()
//        controller.delegate = self
//        return controller
//    }()
//
//    lazy var uploadFileVC: IOPFileUploadController = {
//        let controller = IOPFileUploadController()
//        controller.delegate = self
//        return controller
//    }()
        
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        edgesForExtendedLayout = []
        title = "创建"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

        tableView.tableFooterView = footerView;
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // MARK: -funtions
//    func jumpFileAction(_ itemList: [String]) {
//        DDLog(itemList)
//
//        let urlString = dataModel.valueText(forKeyPath: itemList[4], defalut: "")
//
//        let controller = IOPFileUploadController()
//        controller.delegate = self
//        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
//        controller.key = itemList[4]
//
//        controller.isUpload = urlString == ""
//        controller.fileUrl = urlString == "" ? nil : NSURL(string: urlString)
//        DDLog("isUpload:%@_fileUrl:%@", controller.isUpload, controller.fileUrl)
//        navigationController?.pushViewController(controller, animated: true);
//    }
//
//    func jumpXiangce(_ itemList:[String]) {
//        let controller = UIStoryboard.storyboard(with: "ParkRecord", identifier: "IOPParkRecordImageViewController") as! IOPParkRecordImageViewController
//        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
//        if let url = URL(string: dataModel.value(forKeyPath: itemList[4]) as! String) {
//            controller.inImageUrlArray = [url]
//        }
//        navigationController?.pushViewController(controller, animated: true)
//    }
//
//    func jumpUploadPicture(_ itemList: [String]) {
//        DDLog(itemList)
//
//        let controller = IOPUploadImageController()
//        controller.delegate = self
//        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
//        controller.key = itemList[4]
//
//        let imgUrl = dataModel.valueText(forKeyPath: itemList[4], defalut: "")
//        controller.imgUrl = imgUrl
//        controller.isFromPickerVC = false
//        controller.showImageDefault = true
//        navigationController?.pushViewController(controller, animated: true)
//    }

    func requestAdd() {
//        viewModel.etcFilesAPI.dataModel = dataModel
//        viewModel.requestETCFilesAdd { (dic) in
//            DDLog(dic)
//            if let code = dic["code"] as? String {
//                if code == "1" {
//                    IOPProgressHUD.showSuccess(withStatus: kAPISuccess)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                        self.popToListController()
//                    }
//                }
//            } else {
//                IOPProgressHUD.showError(withStatus: dic["message"] as? String)
//            }
//        }
//    }
}

extension \(prefix)Controller: UITableViewDataSource, UITableViewDelegate{
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = list[section]
        return sections.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sections = list[indexPath.section]
        let itemList = sections[indexPath.row]
        return itemList[2].cgFloatValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = list[indexPath.section]
        let itemList = sections[indexPath.row]
        let value0 = itemList[0]
        let value2 = itemList[2]
        let value3 = itemList[3]
        let value4 = itemList[4]
        
        switch itemList[1] {
        case "UITableViewCellTitle":
            let cell = UITableViewCellTitle.cellWithTableView(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            cell.labelLeft.textColor = .textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.btn.isHidden = value3 == ""
            
            cell.labelLeft.text = value0
            cell.btn.addActionHandler({ (control) in
                UIAlertController.showAlert(value0, message: value3, alignment: .left)
                
            }, for: .touchUpInside)
//            cell.getViewLayer()
            return cell
            
        case "UITableViewCellTextField":
            let cell = UITableViewCellTextField.cellWithTableView(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = .textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.textfield.rightViewMode = .never;
            cell.textfield.textAlignment = .left

            cell.labelLeft.text = value0
            cell.textfield.placeholder = value3
            cell.textfield.text = dataModel.valueText(forKeyPath: value4, defalut: "")
            cell.block { (textField) in
                self.dataModel.setValue(textField.text ?? "", forKeyPath: value4)
//              DDLog("%@_%@_", value4, self.dataModel.valueText(forKeyPath: value4))
            }
//            cell.getViewLayer()
            return cell
            
        case "UITableViewCell":
            let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellValue1", style: .value1)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = .textColor3;

            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.detailTextLabel?.textColor = .theme
            cell.accessoryType = .disclosureIndicator;
            
            cell.textLabel?.text = value0
            cell.detailTextLabel?.text = "上传"
            
            let fileTitles: [String] = value3.components(separatedBy: ",")
            cell.detailTextLabel?.text = fileTitles.first!

            let hasAsterisk = value0.contains("*")
            if hasAsterisk {
                cell.textLabel?.attributedText = cell.textLabel!.text!.toAsterisk(cell.textLabel!.textColor, font: cell.textLabel!.font.pointSize)
            }
            
            if value4.contains("etc_") {
                let result: String = dataModel.valueText(forKeyPath: value4, defalut: "")
                let validUrl = result.hasPrefix("http")
                cell.detailTextLabel?.text = validUrl ? fileTitles.first : fileTitles.last
//                cell.detailTextLabel?.textColor = hasPicture ? UIColor.gray : UIColor.theme
            }

//            cell.getViewLayer()
            return cell;
            
        case "UITableViewCellSegment":
            let cell = UITableViewCellSegment.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = .textColor3
            cell.isHidden = itemList[2].cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")

            cell.labelLeft.text = value0
            cell.segmentCtl.itemList = (itemList.last! as NSString).components(separatedBy: ",")
            let index = dataModel.valueText(forKeyPath: value4, defalut: "0") == "0" ? 0 : 1
            cell.segmentCtl.selectedSegmentIndex = index
//            cell.segmentCtl.addTarget(self, action: #selector(handleActionSender(_:)), for: .valueChanged)
            cell.segmentCtl.addActionHandler({ (control) in
                guard let sender = control as? UISegmentedControl else { return }
//                DDLog(sender.selectedSegmentIndex)
////                let value = String(sender.selectedSegmentIndex)
//                let value: String = sender.selectedSegmentIndex == 0 ? "0" : "1"
                self.dataModel.setValue(value, forKeyPath: value4)
                self.tableView.reloadData()
//                DDLog("%@_%@_%@, sender.selectedSegmentIndex, value4, value)

            }, for: .valueChanged)
//            cell.getViewLayer()
            return cell
            
        default:
            break
        }
        let cell = UITableViewCellZero.cellWithTableView(tableView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sections = list[indexPath.section]
        let itemList = sections[indexPath.row]
        
        if itemList[4].contains("_img") {
            jumpUploadPicture(itemList)
        }
        else if itemList[4].contains("etc_") {
            jumpFileAction(itemList)

        } else if itemList[0].contains("开户行所在地") {
            //地址选择器
//          present(navController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.01;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel();
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections - 1 {
            return 10.01;
        }
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel();
    }
}
        
extension \(prefix)Controller: IOPUploadImageControllerDelegate{
    func uploadImage(_ url: String, forKey key: String) {
        DDLog("%@_%@", key, url)
        dataModel.setValue(url, forKeyPath: key)
        tableView.reloadData()
    }
}
        
extension \(prefix)Controller: IOPFileUploadControllerDelegate{
    func fileUpload(_ url: String, forKey key: String) {
        DDLog("%@_%@", key, url)
        dataModel.setValue(url, forKeyPath: key)
        tableView.reloadData()
    }
}

"""
    }
}
