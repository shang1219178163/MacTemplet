//
//  NNViewControllerDetailCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/14.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


class NNViewControllerDetailCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)

import UIKit
///
class \(prefix)Controller: UIViewController {

    
    @objc var parkModel: IOPParkModel = IOPParkModel()
    @objc var dataModel: IOPParkModel = IOPParkModel(){
       didSet{
           tbView.reloadData()
       }
   }

    let titles = [["车场编号:,parkCode", "总  车  位:,parkSpaceCount", "ARM版本:,armVersion", "创建时间:,create_at",
                  "车场类型:,typeDes", "车场管理员:,user_name", "联系方式:,phone", "GPS      :,gpsDes",
                  "车场位置:,positionDes", "详细地址:,address", ],
                  ["安全证书,certificate", "通道信息,IOPParkChannelListController", "车场设备,IOPParkDeviceListController",]
                    ]
        
    lazy var viewModel: \(prefix)ViewModel = {
        let viewModel = \(prefix)ViewModel()
        viewModel.delegate = self
        viewModel.parController = self
        return viewModel
    }()
    
    lazy var rightBtn: UIButton = {
        let button = UIButton.create(.zero, title: "编辑", imgName: nil, type: 6)
        button.sizeToFit()
        button.addActionHandler({ (control) in
            let controller = IOPParkEditController()
            controller.rightBtn.isHidden = true
            controller.dataModel = self.dataModel
            self.navigationController?.pushViewController(controller, animated: true)
            
        }, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupExtendedLayout()
        title = "详情"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        viewModel.requestInfo()
    }
    
    // MARK: - funtions
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        tbView.rowHeight = 50
        view.addSubview(tbView)
        
        tbView.tableHeaderView = topView;
    }
 
    func rowCount(_ section: Int) -> Int {
        var count = 0
        switch section {
        case 0:
            count = titles.first!.count
            
        case 1:
            count = 1
            
        case 2:
            count = 3
            
        default:
            break
        }
        return count
    }


}

extension \(prefix)Controller: UITableViewDataSource, UITableViewDelegate{
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount(section);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 30
        }
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellValue1", style: .value1)
            cell.textLabel?.textColor = UIColor.textColor9
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            
            cell.detailTextLabel?.textColor = UIColor.textColor3
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            //
            let cellList: [String] = UITableView.sectionCellList(titles, indexPath: indexPath);
            
            cell.textLabel?.text = cellList.first
            cell.detailTextLabel?.text = dataModel.valueText(forKey: cellList.last!)
            
//            cell.separatorInset = indexPath.row == 0 ? .zero : UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
//            cell.getViewLayer()
            return cell;

        } else if indexPath.section == 1 {
            let cell = UITableViewCellOne.dequeueReusableCell(tableView)
            cell.type = 1;
            cell.labelLeft.textColor = UIColor.textColor3

            cell.labelRight.textColor = UIColor.theme
            cell.labelRight.font = UIFont.systemFont(ofSize: 13)
            cell.labelRight.adjustsFontSizeToFitWidth = false
            cell.labelRight.lineBreakMode = .byTruncatingTail
            //
            let cellList: [String] = UITableView.sectionCellList(titles, indexPath: indexPath);

            cell.labelLeft.text = cellList.first
            cell.labelRight.text = dataModel.valueText(forKey: cellList.last!, defalut: "")

//            cell.getViewLayer()
            return cell;
            
        } else if indexPath.section == 2 {
            let cell = UITableViewCell.dequeueReusableCell(tableView)
            cell.textLabel!.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel!.text = "--"
            cell.textLabel!.textColor = UIColor.textColor3;
            //
            let cellList: [String] = UITableView.sectionCellList(titles, indexPath: indexPath);
            cell.textLabel?.text = cellList.first

            if indexPath.row == 0 {
                cell.accessoryView = {
                    let rect = CGRectMake(0, 0, 70, 35)
                    let btn = UIButton.create(rect, title: "查看证书", imgName: nil, type: 6)
                    btn.addActionHandler({ (control) in
//                        self.dataModel.certificate.copyToPasteboard(true)
                        IOPApplicationSetting.downloadCertificate()

                    }, for: .touchUpInside)
                    return btn
                }()
            } else {
                cell.accessoryType = .disclosureIndicator
            }
            return cell;
        }
        return UITableViewCell.dequeueReusableCell(tableView);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let controller = IOPParkTagsController()
            controller.parkModel = dataModel
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.section == 2 {
            let cellList: [String] = UITableView.sectionCellList(titles, indexPath: indexPath);
            
            guard let controller = UICtrFromString(cellList.last!) as? UIViewController else {
                return
            }
            controller.setValue(dataModel, forKey: "parkModel")
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel();
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel();
    }
}


extension \(prefix)Controller: \(prefix)ViewModelDelegate{

    func request(with model: IOPParkModel) {
        dataModel = model
    }
}

"""
    }
}
