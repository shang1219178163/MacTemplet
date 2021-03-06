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
        
/// 列表
@objcMembers class \(prefix)Controller: UIViewController{
    
    /// 数据请求返回
    var dataModel = NSObject()
    
    lazy var viewModel = \(prefix)ViewModel()
        
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
        
    lazy var rightBtn: UIButton = {
        let view = UIButton.create(title: "Next", textColor: .white, backgroundColor: .theme)
        view.addActionHandler({ (sender) in
//            let controller = UIViewController()
//            self.navigationController?.pushViewController(controller, animated: true)
            
        }, for: .touchUpInside)
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: CGRectMake(0, 0, kScreenWidth - 70, 50))
        view.textField?.placeholder = "请输入名称搜索";

//        view.delegate = self
        return view
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExtendedLayout()
        title = ""
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - funtions
    func setupUI() {
        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

        view.addSubview(tableView);
        tableView.tableHeaderView = searchBar

//        searchBar.isHidden = true
    }

    func requestForSearch(_ searchbar: UISearchBar) {
//        viewModel.listAPI.name = searchBar.text!;
        tableView.mj_header.beginRefreshing();
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
        cell.textLabel?.textColor = .textColor3;

        cell.detailtextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.text = "--"
        cell.detailTextLabel?.textColor = .textColor6;
        cell.accessoryType = .disclosureIndicator;
        
//        guard let model = dataList[indexPath.row] as? IOPParkModel else { return cell; }
//        cell.textLabel?.text = model.name
//        cell.detailTextLabel?.text = model.statusDes
//        cell.detailTextLabel?.textColor = model.statusDes == "已接入" ? UIColor.theme : UIColor.textColor9;

//        cell.getViewLayer()
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let model = dataList[indexPath.row] as? IOPParkModel else { return }
//        let controller = IOPParkDetailController()
//        controller.parkModel = model
//        navigationController?.pushViewController(controller, animated: true)
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


//extension \(prefix)Controller: \(prefix)ViewModelDelegate{
//
//    func request(with model: \(prefix)RootModel, isRefresh: Bool, hasNextPage: Bool) {
//
//        DispatchQueue.global().async {
//            self.dataModel = model;
//            if isRefresh == true {
//                self.dataList.removeAllObjects()
//            }
////            self.dataList.addObjects(from: self.dataModel.records)
//            DispatchQueue.main.async {
//                IOPProgressHUD.dismiss()
//                self.tableView.mj_header.endRefreshing();
//                self.tableView.mj_footer.endRefreshing();
//                self.tableView.mj_footer.isHidden = !hasNextPage;
//                self.tableView.isHidden = (self.dataList.count <= 0);
//                self.tableView.reloadData();
//            }
//        }
//    }
//}

"""
    }
}
