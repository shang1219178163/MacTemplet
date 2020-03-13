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

/// 详情
@objcMembers class \(prefix)Controller: UIViewController {

    var model = NSObject()
    
    var recordID: String = ""

    var dataModel = NSObject()

    lazy var viewModel = \(prefix)ViewModel()
        
    lazy var list: [[[String]]] = {
        var array: [[[String]]] = [
            [["电子发票进件", "UITableViewCell", "50.0", "", "statusDes",],
            ["进件车场", "UITableViewCell", "50.0", "", "park_name",],
            ["复用车场", "UITableViewCell", "50.0", "请输入收款人", "park_name_copy", ],
            ["进件方式", "UITableViewCell", "50.0", "请输入销货方地址", "is_copyDes", ],
            ["进件时间", "UITableViewCell", "50.0", "收件人联系方式", "creat_timeDes", ],
            ["审核时间", "UITableViewCell", "50.0", "收件人联系方式", "update_timeDes", ],
            ["驳回原因", "UITableViewCell", "50.0", "收件人联系方式", "reject_reason", ],

            ],
            [["企业信息", "UITableViewCell", "50.0", "", "",],
            ["开票主体名称" + kBlankOne, "UITableViewCell", "50.0", "请输入开票主体名称", "invoicing_name", ],
            ["纳税人识别号" + kBlankOne, "UITableViewCell", "50.0", "请输入纳税人识别号", "ti_number", ],
            ["销货方地址" + kBlankTwo, "UITableViewCell", "50.0", "请输入销货方地址", "seller_address", ],
            ["销货方电话" + kBlankTwo, "UITableViewCell", "50.0", "请输入销货方电话", "seller_telephone", ],
            ["销货方开户行" + kBlankOne, "UITableViewCell", "50.0", "请输入销货方开户行", "seller_bank", ],
            ["销货方银行帐号", "UITableViewCell", "50.0", "请输入销货方银行账号", "seller_bank_account", ],
            ["收款人" + kBlankFour + kBlankQuarter, "UITableViewCell", "50.0", "请输入收款人", "payee", ],
            ["复核人" + kBlankFour + kBlankQuarter, "UITableViewCell", "50.0", "输入复核人", "reviewer", ],
            ["开票人" + kBlankFour, "UITableViewCell", "50.0", "请输入开票人", "drawer", ],
            ["税率" + kBlankFive, "UITableViewCell", "50.0", "请输入税率", "tax_rate", ],
            ["税收分类编码" + kBlankOne + kBlankHalf, "UITableViewCell", "50.0", "请输入税收分类编码", "tax_code", ],
            ],
            [["收货信息", "UITableViewCell", "50.0", "", "",],
            ["收件人" + kBlankFour, "UITableViewCell", "50.0", "请输入收款人", "receipter", ],
            ["收件地址" + kBlankThree, "UITableViewCell", "50.0", "请输入销货方地址", "receipt_address", ],
            ["收件人联系方式", "UITableViewCell", "50.0", "收件人联系方式", "receipt_phone", ],
            ],
        ]
        return array
    }()
    
    lazy var rightBtn: UIButton = {
        let button = UIButton.create(.zero, title: "进件须知", imgName: nil, type: 6)
        button.sizeToFit()
        button.addActionHandler({ (control) in
//            let controller = IOPInPartAgreementController()
//            controller.type = "1"
//            self.navigationController?.pushViewController(controller, animated: true)
            
        }, for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView.create(self.view.bounds, style: .plain, rowHeight: 40)
        view.dataSource = self
        view.delegate = self

        return view
    }()
    
    lazy var footerView: NNTableFooterView = {
        let view = NNTableFooterView.create("下一步", topPadding: 30);
        view.btn.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return view
    }()
    
    @objc func handleAction(_ sender: UIButton) {
        view.endEditing(true)
//        DDLog(sender.currentTitle)
        
//        let controller = IOPInpartInvoiceReceiptController()
//        controller.dataModel = dataModel
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    lazy var noticeLabel: UILabel = {
        let rect = CGRectMake(0, 0, kScreenWidth, 30)
        let view = UILabel.create(rect, textColor: UIColorHexValue(0xE9852C), type: 2)
        view.font = UIFont.systemFont(ofSize: 12);
        view.backgroundColor = UIColorHexValue(0xFFEBBB)
        view.text = "   未通过的进件，可通过“创建进件”再次申请"
        return view
    }()

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "详情"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

        view.addSubview(noticeLabel);
//        tableView.tableFooterView = footerView;
        view.addSubview(tableView)
        
        handleRequestInaprtDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noticeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.height.equalTo(30);
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeLabel.snp.bottom).offset(0);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(0);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        handleRequestInaprtDetail()
    }
    
    func handleRequestInaprtDetail() {
        if recordID == "" {
//            DDLog(self.model.creat_time, self.model.update_time)
            dataModel = model
            if ["1", "2"].contains(dataModel.status) == false {
                noticeLabel.snp.remakeConstraints { (make) in
                    make.height.equalTo(0);
                }
                tableView.snp.remakeConstraints { (make) in
                    make.height.equalTo(self.view.bounds.height);
                }
            }
            tableView.reloadData()
            requestInaprtDetail(model.topic_id)
        } else {
            requestInaprtDetail(recordID)
        }
    }

    func requestInaprtDetail(_ ID: String?) {
        viewModel.detailAPI.order_id = ID ?? ""
        viewModel.requestDetail { (model) in
//            DDLog(model.title)
            self.dataModel = model.labels
            self.dataModel.status = self.model.status
            self.dataModel.reject_reason = self.model.reject_reason ?? ""
            self.dataModel.creat_time = self.model.creat_time
            self.dataModel.update_time = self.model.update_time
            self.tableView.reloadData()
        }
    }
    
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
        return indexPath.row == 0 ? tableView.rowHeight : 28
//        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = list[indexPath.section]
        let itemList = sections[indexPath.row]
        let value0 = itemList[0]
        let value2 = itemList[2]
        let value3 = itemList[3]
        let value4 = itemList[4]
        
        switch itemList[1] {
        case "UITableViewCell":
            let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellValue1", style: .value1)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = UIColor.textColor6;

            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.detailTextLabel?.textColor = UIColor.theme
            
            cell.textLabel?.text = value0
            cell.detailTextLabel?.text = "上传"
                        
            let result: String = dataModel.valueText(forKeyPath: value4, defalut: "-")
            if result.contains("http") {
                cell.detailTextLabel?.text = kTitleLook
                cell.detailTextLabel?.textColor = UIColor.theme
                cell.accessoryType = .disclosureIndicator;

            } else {
                cell.detailTextLabel?.text = result
                cell.detailTextLabel?.textColor = UIColor.textColor3
                cell.accessoryType = .none;
            }
            
            if indexPath.row == 0 {
                cell.textLabel?.textColor = UIColor.textColor3;
                cell.detailTextLabel?.text = result
                cell.detailTextLabel?.textColor = dataModel.statusDesColor
            } else {
                cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            }
            cell.separatorInset = indexPath.row == 0 ? .zero : UIEdgeInsetsMake(0, 0, 0, kScreenWidth);

//            cell.getViewLayer()
            return cell;
            
        case "UITableViewCellTitle":
            let cell = UITableViewCellTitle.cellWithTableView(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            
            cell.btn.isHidden = true

            cell.labelLeft.text = value0
//            cell.getViewLayer()
            return cell
            
        default:
            break
        }
        let cell = UITableViewCellZero.cellWithTableView(tableView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.01;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel();
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel();
    }
}

"""
    }
}
