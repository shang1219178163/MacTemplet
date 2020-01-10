//
//  NNViewControllerModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNViewControllerModel: NSObject {

    static func getContent(with name: String) -> String {
        return """
        
        import UIKit
        ///
        class \(name)Controller: UIViewController{
            
            /// 数据请求返回
            var dataModel = NSObject()
            
            lazy var viewModel: \(name)ViewModel = {
                let viewModel = \(name)ViewModel()
                viewModel.delegate = self;
                return viewModel
            }()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                setupExtendedLayout()
                title = ""
                setupUI()
            }
            
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()

            }
            
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated);
                
                tableView.mj_header.beginRefreshing()
            }
            
                
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            // MARK: - funtions
            func setupUI() {
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
                
                view.addSubview(tipLab);
                view.addSubview(tableView);
                                
                tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {

                });
                
                tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {

                });
            }
            

            //MARK: -funtions

            
            //MARK: -lazy
            lazy var rightBtn: UIButton = {
                let button = UIButton.create(.zero, title: "保存", imgName: nil, type: 6)
                button.sizeToFit()
                button.addActionHandler({ (control) in
                    
                }, for: .touchUpInside)
                return button
            }()
            
        }

        extension \(name)Controller: UITableViewDataSource, UITableViewDelegate{
            //    MARK: - tableView
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1;
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return dataList.count;
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return tableView.rowHeight
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = UITableViewCell.cellWithTableView(tableView, identifier: "UITableViewCellSubtitle", style: .subtitle)
                cell.textLabel!.font = UIFont.systemFont(ofSize: 15)
                cell.textLabel!.text = "--"
                cell.textLabel!.textColor = UIColor.textColor3;

                cell.detailTextLabel!.font = UIFont.systemFont(ofSize: 13)
                cell.detailTextLabel?.text = "--"
                cell.detailTextLabel?.textColor = UIColor.textColor6;
                cell.accessoryType = .disclosureIndicator;
                
        //        guard let model = dataList[indexPath.row] as? IOPParkModel else { return cell; }
        //        cell.textLabel!.text = model.name
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
                return 0.01;
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


        extension \(name)Controller: \(name)ViewModelDelegate{


        }
"""
    }
}
