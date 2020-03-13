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
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
import UIKit
        
///
@objcMembers class \(prefix)Controller: UIViewController{
        
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExtendedLayout()
        title = ""
        setupUI()
        
        tableView.mj_header.beginRefreshing()
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
        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

    }

}

"""
    }
    
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "h")
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
        let copyRight = NSApplication.getCopyright(with: name, type: "m")
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        return """
\(copyRight)
#import "\(prefix)Controller.h"


@interface \(prefix)Controller ()


@end

@implementation \(prefix)Controller

#pragma mark --lifecycle
        
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
}
        
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
        
}
        
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
}
        
    
#pragma mark -funtions
        
        
#pragma mark -lazy
    

@end

"""
    }

}
