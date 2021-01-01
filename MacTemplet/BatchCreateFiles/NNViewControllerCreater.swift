//
//  NNViewControllerCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


class NNViewControllerCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
import UIKit
        
///
@objcMembers class \(prefix)Controller: UIViewController{
        
    var dataList = NSMutableArray()

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
        
    // MARK: - lifecycle
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
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - funtions
    func setupUI() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

        view.addSubview(tableView)
    }

}
        
extension \(prefix)Controller: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellSubtitle", style: .subtitle)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.text = "--"
        cell.textLabel?.textColor = .textColor3;

        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.text = "--"
        cell.detailTextLabel?.textColor = .textColor6;
        cell.accessoryType = .disclosureIndicator;
        
        return cell
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
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel();
    }
}


"""
    }
    
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: "h")
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface \(prefix)Controller : UIViewController


@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: "m")
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
#import "\(prefix)Controller.h"


@interface \(prefix)Controller ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) UITableView *tableView;
        
@end

@implementation \(prefix)Controller

#pragma mark --lifecycle
        
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setupUI];
    [self.tableView reloadData];
}
        
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
        
}
        
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
}
        
#pragma mark -UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"{%@, %@}", @(indexPath.section), @(indexPath.row)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UILabel alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UILabel alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark -funtions

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    
}

        
        
#pragma mark -lazy

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsZero;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
            
            tableView.estimatedRowHeight = 0.0;
            tableView.estimatedSectionHeaderHeight = 0.0;
            tableView.estimatedSectionFooterHeight = 0.0;
            tableView.rowHeight = 50;
            
            tableView.dataSource = self;
            tableView.delegate = self;
            
            //背景视图
//            UIView *view = [[UIView alloc]initWithFrame:tableView.bounds];
//            view.backgroundColor = UIColor.cyanColor;
//            tableView.backgroundView = view;
//            tableView.bounces = NO;
            tableView;
        });
    }
    return _tableView;
}


@end

"""
    }

}
