//
//  NNViewControllerModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

/// 列表
class NNViewControllerListCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
import UIKit
import MJRefresh

/// 列表
@objcMembers class \(prefix)Controller: UIViewController{
    
    /// 数据请求返回
    var dataModel = NSObject()
    
    lazy var viewModel = NSObject()
        
    var dataList = NSMutableArray()

    // MARK: - lazy
    lazy var tableView: UITableView = {
        let view = UITableView.create(self.view.bounds, style: .plain, rowHeight: 60)
        view.dataSource = self
        view.delegate = self

//        view.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            self.viewModel.requestRefresh()
//        });
//
//        view.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            self.viewModel.requestRefresh()
//        });
        return view
    }()
        

    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: CGRectMake(0, 0, kScreenWidth - 70, 50))
        view.textField?.placeholder = "请输入关键字搜索";
        view.textField?.font = UIFont.systemFont(ofSize: 13)

        return view
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.mj_header?.beginRefreshing()
    }
    
    // MARK: - funtions
    func setupUI() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = "列表"
        navigationItem.rightBarButtonItems = ["Next"].map({
            return UIBarButtonItem(obj: $0) { item in
                DDLog(item.title)
            }
        })
        
        tableView.tableHeaderView = searchBar
        view.addSubview(tableView)

//        searchBar.isHidden = true
    }

    @objc func request(_ isRefresh: Bool) {
//        api.startRequest { (manager, jsonData) in
//            self.tableView.mj_header.endRefreshing()
//            guard let jsonData = jsonData else { return }
//            guard let model = try? PHHQrcodeOverageTotalModel(dictionary: jsonData) else { return }
//            if PHHCommonStorage.giveCouponType() == .safetyGiveCouponType {
//                self.dataList.append(contentsOf: model.listModels.safeListModels)
//                if isRefresh {
//                    self.dataList.removeAll()
//                }
//                self.tableView.reloadData()
//            }
//
//        } failedBlock: { (manager, error) in
//            self.tableView.mj_header.endRefreshing()
//            guard let error = error else { return }
//            PHHHttpErrorHandler.handError(error: error)
//        }
    }
}

extension \(prefix)Controller: UITableViewDataSource, UITableViewDelegate{
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellSubtitle", style: .subtitle)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.text = "--"
        cell.textLabel?.textColor = .textColor3

        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.text = "--"
        cell.detailTextLabel?.textColor = .textColor6
        cell.accessoryType = .disclosureIndicator
        
//        guard let model = dataList[indexPath.row] as? IOPParkModel else { return cell; }
//        cell.textLabel?.text = model.name
//        cell.detailTextLabel?.text = model.statusDes
//        cell.detailTextLabel?.textColor = model.statusDes == "已接入" ? UIColor.theme : UIColor.textColor9;

//        cell.getViewLayer()
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let model = dataList[indexPath.row] as? IOPParkModel else { return }
//        let vc = IOPParkDetailController()
//        vc.parkModel = model
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableView.numberOfSections - 1 ? 10.01 : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel()
    }
}


"""
    }
}
