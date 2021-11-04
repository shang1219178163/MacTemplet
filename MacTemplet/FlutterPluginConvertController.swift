//
//  FlutterPluginConvertController.swift
//  MacTemplet
//
//  Created by shangbinbin on 2021/11/1.
//  Copyright © 2021 Bin Shang. All rights reserved.
//
/*
 let urlStr = "https://discussionschinese.apple.com/thread/252751342?page=1"
 let messgae = "1. 因为系统 Sip 开启的原因, mac app 开启'完全磁盘访问权限'进行拖拽时仍会提示 'Operation not permitted'.详情见 \(urlStr);
 2. 当用户第一次选择除(下载文件目录)以外的 .dart 文件之后,可以通过拖拽工程目录的方式进行拖拽,提高效率;
 3. 不喜欢复杂的直接莫粘贴复制,不受系统文件权限影响;"
 */

import Cocoa
import SnapKit
import SwiftExpand

/// Flutter Plugin.dart 文件方法转化 OC
@available(macOS 10.13, *)
class FlutterPluginConvertController: NSViewController {
    
    lazy var destinationView: DragDestinationView = {
        let view = DragDestinationView(types: [.tiff, .color, .string, .fileURL, .html])
        view.delegate = self
        return view
    }()
    
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 14, weight: .light)
//        view.isEditable = false
//        view.backgroundColor = .systemYellow
//        view.alignment = .center
        view.string = ""
        view.delegate = self
        return view;
    }()
    
    lazy var textViewConvert: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 14, weight: .light)
        view.isEditable = false
//        view.backgroundColor = .systemGreen
//        view.alignment = .center
        view.string = ""
        return view;
    }()
    
    
    lazy var btn: NSButton = {
        let view = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .regularSquare
        view.title = "刷新"

        view.addActionHandler { (sender) in
            NSApp.keyWindow?.makeFirstResponder(nil)
            self.createFiles()
        }
        return view
    }()
    
    lazy var btnChoose: NSButton = {
        let view = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .regularSquare
        view.title = "选择文件"
        view.addActionHandler { (sender) in
            let panel = NSOpenPanel.open(fileTypes: nil)
            DDLog(panel.url)
            if let url = panel.url {
                self.handleChooseFile(url.absoluteString)
            }
        }
        return view
    }()
    
    lazy var btnOpen: NSButton = {
        let view = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .regularSquare
        view.title = "打开文件生成目录"

        view.addActionHandler { (sender) in
            NSWorkspace.shared.open(FileManager.downloadsDir!)
        }
        return view
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["plugin", "main.dart",]

        view.addActionHandler({ sender in
            self.textView.setHighlightedCode()
            if self.objcH == "" {
                self.createFiles()
            } else {
                self.convertOut()
            }
        }, trackingMode: .selectOne)
        return view;
    }()
    
    
    var typeConverDic: [String: String] {
        return [
            "Map<String, dynamic>": "NSDictionary<NSString *, id> *",
            "List<String>": "NSArray<NSString *> *",
            "String": "NSString *",
            "int": "NSNumber *",
            "double": "NSNumber *",
            "bool": "NSNumber *",
        ]
    }
    
    var objcH = ""
    
    var objcM = ""
    
    var dartMain = ""
    
    var clsName = ""

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        title = "Plugin插件方法生成"

        view.addSubview(destinationView)
        view.addSubview(textView.enclosingScrollView!)
        view.addSubview(textViewConvert.enclosingScrollView!)
        view.addSubview(btn)
        view.addSubview(btnOpen)
        view.addSubview(btnChoose)
        view.addSubview(segmentCtl)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        guard let textViewEnclosingScrollView = textView.enclosingScrollView,
              let textViewCreateEnclosingScrollView = textViewConvert.enclosingScrollView
        else { return }
        
        let spacing = 10
        
        destinationView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        btn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-spacing)
            make.right.equalToSuperview().offset(-spacing)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        segmentCtl.snp.makeConstraints { (make) in
            make.centerY.equalTo(btn)
            make.right.equalTo(btn.snp.left).offset(-spacing)
            make.height.equalTo(btn)
            make.width.equalTo(200)
        }
        
        textViewEnclosingScrollView.snp.remakeConstraints { (make) in
            make.top.left.equalToSuperview().offset(spacing)
            make.right.equalTo(destinationView).offset(-spacing)
            make.bottom.equalTo(btn.snp.top).offset(-spacing)
        }

        textViewCreateEnclosingScrollView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(spacing)
            make.left.equalTo(destinationView.snp.right)
            make.right.equalToSuperview().offset(-spacing)
            make.bottom.equalTo(btn.snp.top).offset(-spacing)
        }
        
        btnChoose.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(btn)
            make.left.equalToSuperview().offset(spacing)
            make.width.equalTo(120)
        }
        
        btnOpen.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(btn)
            make.left.equalTo(btnChoose.snp.right).offset(spacing)
            make.width.equalTo(120)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
//        textView.string = """
//
//import 'dart:async';
//
//import 'package:flutter/services.dart';
//
//class Hello5 {
//  static const MethodChannel _channel = MethodChannel('hello5');
//
//  ///
//  static Future<String> getPlatformVersion() async {
//    String value = await _channel.invokeMethod('getPlatformVersion');
//    return value;
//  }
//
//  ///
//  static Future<String> getAppVersion(Map<String, dynamic> val) async {
//    String value = await _channel.invokeMethod('getAppVersion', val);
//    return value;
//  }
//
//  static Future<String> getAppVersion1(List<String> val) async {
//    String value = await _channel.invokeMethod('getAppVersion1', val);
//    return value;
//  }
//
//  static Future<String> getAppVersion2(String val) async {
//    String value = await _channel.invokeMethod('getAppVersion2', val);
//    return value;
//  }
//
//  static Future<String> getAppVersion3(int val) async {
//    String value = await _channel.invokeMethod('getAppVersion3', val);
//    return value;
//  }
//
//  static Future<String> getAppVersion4(double val) async {
//    String value = await _channel.invokeMethod('getAppVersion4', val);
//    return value;
//  }
//
//  static Future<String> getAppVersion5(bool val) async {
//    String value = await _channel.invokeMethod('getAppVersion5', val);
//    return value;
//  }
//}
//
//"""
//        NSPasteboard.general.pasteboardItems?.forEach({ item in
//            let content = item.string(forType: .string)
//            DDLog(content)
//        })
    }
    
    // MARK: -funtions
    
    func createFiles() {
        if textView.string.isEmpty || textView.string.contains("class") == false{
            return
        }
        
        let lines = textView.string.components(separatedBy: "\n")
        if lines.count == 0{
            return
        }
//        DDLog(lines.count)

        clsName = lines.filter { $0.contains("class") }
            .first!
            .components(separatedBy: " ")[1]
                
        let tuples: [(DartMethodModel, String, String)] = lines.filter { $0.contains("Future<") }
            .map { e -> (DartMethodModel, String, String) in
                let titles = e.trimmed.components(separatedBy: " ")
                let prefix = titles[0].hasPrefix("static") ? "+" : "-"
                
                let returnVal = titles[1]

                let name = e.substring("> ", suffix: "(", isContain: false)
                let param = e.substring("(", suffix: ")", isContain: true)
                let paramsType = param.substring("(", suffix: " ", isContain: false)
                let paramsName = param.replacingOccurrences(of: paramsType, with: "").trimmedBy("() ")
                
                let body = e.substring("{", prefixOptions: .backwards, suffix: "}", isContain: false)

                let methodModel = DartMethodModel(
                    isStatic: titles[0].hasPrefix("static"),
                    isFuture: true,
                    name: name,
                    paramsType: paramsType,
                    paramsName: paramsName,
                    returnVal: returnVal,
                    body: body)
                
                let ocParamsType = typeConverDic[paramsType] ?? "id"
                
                let ocFuncName = "\(prefix) (void)\(name):(\(ocParamsType))params callback:(FlutterResult)callback"
                var ocFuncBody = """
\(ocFuncName) {
    NSString *result = [NSString stringWithFormat:@"%@\tparams: %@", NSStringFromSelector(_cmd), params];
    callback(result);
}
"""
                switch paramsType {
                case "double":
                ocFuncBody = """
\(ocFuncName) {
    NSString *result = [NSString stringWithFormat:@"%@  params: %.2f", NSStringFromSelector(_cmd), params.floatValue];
    callback(result);
}
"""
                case "bool":
                ocFuncBody = """
\(ocFuncName) {
    NSString *result = [NSString stringWithFormat:@"%@  params: %@", NSStringFromSelector(_cmd), params.boolValue ? @"true" : @"false"];
    callback(result);
}
"""
                default:
                    break
                }
                return (methodModel, ocFuncName + ";", ocFuncBody);
            }
//        DDLog(className, tuples.map{$0.1});
        objcH = createObjcH(tuples, className: clsName)
        objcM = createObjcM(tuples, className: clsName)
        dartMain = createDartExampleMain(tuples, clsName: clsName)
                
        convertOut()
        
        FileManager.createFile(content: objcH, name: "\(clsName)Plugin", type: "h", openDir: false)
        FileManager.createFile(content: objcM, name: "\(clsName)Plugin", type: "m", openDir: false)
        FileManager.createFile(content: dartMain, name: "main", type: "dart", openDir: false)
        
//        NSWorkspace.shared.open(FileManager.downloadsDir!)
    }
    
    /// 创建 plugin.h 文件
    func createObjcH(_ tuples: [(DartMethodModel, String, String)], className: String) -> String {
        let contentH = """
#import <Flutter/Flutter.h>

@interface \(className)Plugin : NSObject<FlutterPlugin>

\(tuples.map{ $0.1 }.joined(separator: "\n\n"))

@end
"""
        return contentH;
    }
    /// 创建 plugin.m 文件
    func createObjcM(_ tuples: [(DartMethodModel, String, String)], className: String) -> String {
        let contentM = """
#import "\(className)Plugin.h"

@implementation \(className)Plugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"\(className.localizedLowercase)"
            binaryMessenger:[registrar messenger]];
  \(className)Plugin* instance = [[\(className)Plugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    // NSLog(@"call.arguments: %@", call.arguments);
    [self reflectMethod:\(className)Plugin.class
               instance:[\(className)Plugin new]
                   Call:call
                 result:result];
}

/// iOS 类方法/实例方法映射(方法格式: * (void)*MethodName*:(id)params callback:(FlutterResult)callback;)
///
/// @param cls 类参数: UserManager.class
/// @param instance 类方法传 nil, 实例方法传对应实例
/// @param call FlutterPlugin 参数
/// @param result FlutterPlugin 参数
- (void)reflectMethod:(Class)cls
             instance:(nullable NSObject *)instance
                 Call:(FlutterMethodCall *)call
               result:(FlutterResult)result {
    NSString *method = call.method; //获取函数名
    id arguments = call.arguments; //获取参数列表
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:callback:", method]);
    
    if ([cls respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [cls methodSignatureForSelector:selector]; // Signature

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = cls;// target
        
        invocation.selector = selector;
        [invocation setArgument:&arguments atIndex:2];
        [invocation setArgument:&result atIndex:3];
        [invocation invoke];
        return;
    }
    
    if (instance && [instance respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [cls instanceMethodSignatureForSelector:selector]; // Signature
    
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = instance;// target
        
        invocation.selector = selector;
        [invocation setArgument:&arguments atIndex:2];
        [invocation setArgument:&result atIndex:3];
        [invocation invoke];
        return;
    }

    NSLog(@"call.method: %@, call.arguments: %@", call.method, call.arguments);
    result(FlutterMethodNotImplemented);
}

#pragma mark - funtions

\(tuples.map{ $0.2 }.joined(separator: "\n\n"))

@end
"""
        return contentM
    }
    /// 创建 plugin example 中 main.dart 页面,方便调试
    func createDartExampleMain(_ tuples: [(DartMethodModel, String, String)], clsName: String) -> String {
        
        let privateVars = """
\(tuples.map{ "\tString _\($0.0.name) = '\($0.0.name)';"  }.joined(separator: "\n"))
"""
        let initPlatformStateContent = """
\(tuples.map{ "\t\t\($0.0.name)();"  }.joined(separator: "\n"))
"""
        
        let privateFuncs = tuples.map{
"""
\(createMainPrivateFunc($0, className: clsName))
"""
        }.joined(separator: "\n\n");
//        let privateFuncs = tuples.map{
//"""
//  Future<void> \($0.0.name)() async {
//    String \($0.0.name) = await Hello5.\($0.0.name)();
//    setState(() {
//      _\($0.0.name) = \($0.0.name);
//    });
//  }
//"""
//        }.joined(separator: "\n\n");
        
        
        let children = tuples.map{
"""
              FlatButton(
                onPressed: () => setState(() {
                  \($0.0.name)();
                }),
                child: Text(_\($0.0.name)),
              ),
"""
        }.joined(separator: "\n");
        
        let content = """
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hello5/hello5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

\(privateVars)

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  /// showSnackBar
  _showSnakeBar(SnackBar snackBar, [bool isReplace = true]) {
    if (isReplace) {
      _scaffoldKey.currentState?.hideCurrentSnackBar();
    }
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  Future<void> initPlatformState() async {

\(initPlatformStateContent)
  }
  
\(privateFuncs)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello5 Plugin example app'),
        ),
        body: _buildBody(),
      ),
    );
  }
  
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
\(children)
            ],
          ),
        ),
      ),
    );
  }
}

"""
        return content
    }
    
    func createMainPrivateFunc(_ tuple: (DartMethodModel, String, String), className: String) -> String {

        var params = ""
//        DDLog(tuple.0.paramsType)
        switch tuple.0.paramsType {
        case "Map<String, dynamic>":
            params = """
    final val = {
      "a": "aaa",
      "b": 99,
      "d": 66.0,
      "c": false
    };
"""
    case "List<String>":
        params = """
    final val = ["a", "b", "c"];
"""
        case "String":
            params = """
    final val = "aaa";
"""
        case "int":
            params = """
    final val = 66;
"""
        case "double":
            params = """
    final val = 88.0;
"""
        case "bool":
            params = """
    final val = false;
"""
        default:
            break
        }
    
        let paramsName = params != "" ? "val" : ""
        
        let body =
"""
  Future<void> \(tuple.0.name)() async {
\(params)
    String result = await Hello5.\(tuple.0.name)(\(paramsName));
    setState(() {
      _\(tuple.0.name) = result;
    });

    _showSnakeBar(SnackBar(content: Text(result)));
  }
"""
        return body
    }
    
    func convertOut() {
//        DDLog(segmentCtl.selectedSegment)
        var content = ""
        if segmentCtl.selectedSegment == 0 {
            content = """
//\(clsName)Plugin.h

\(objcH)

/*******************************分割线*******************************/

//\(clsName)Plugin.m

\(objcM)

"""
        } else {
            content = """
\(dartMain)
"""
        }
        textViewConvert.string = content
        textViewConvert.setHighlightedCode()
    }
    
    ///获取选择的文件内容
    func handleChooseFile(_ path: String) {
//         let dbPath = "/Users/shang/hello5/lib/hello5.dart"
        let urlString = path.replacingOccurrences(of: "file:", with: "")
        do {
            let content = try String(contentsOfFile: urlString)
//            DDLog(content)
            textView.string = content
            textView.setHighlightedCode()
            
            createFiles()
        } catch {
            textView.string = ""
            textViewConvert.string = ""

            print("error: \(error)")
            showErrorAlert("\(error)")
        }
    }
    
    func showErrorAlert(_ message: String) {
        NSAlert(title:"提示", message: message, btnTitles: ["知道了"]).runModal()
    }
}

extension FlutterPluginConvertController: NSTextViewDelegate {

    func textDidChange(_ notification: Notification) {

        if textView.string.isEmpty {
            textViewConvert.string = ""
            return
        }
        textView.setHighlightedCode()
        createFiles()
    }
    
    func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
        DDLog(replacementString)
        if let replacementString = replacementString,
           replacementString.hasPrefix("file:/") {
            handleChooseFile(replacementString)
            return false
        }
        return true
    }
}



@available(OSX 10.13, *)
extension FlutterPluginConvertController: DragDestinationViewDelegate {
    
    func process(_ obj: Any, pasteBoard: NSPasteboard) {
        switch obj {
        case let value as String:
            print(#function, #line, "String", value)
//            textView.string = value
            handleChooseFile(value);

        case let value as NSColor:
            print(#function, #line, "NSColor", value)
            textView.textColor = value
            
        case let value as URL:
            print(#function, #line, "URL", value.absoluteString.removingPercentEncoding ?? "")
            textView.string = value.lastPathComponent.removingPercentEncoding ?? ""
            
        default:
            print(#function, #line, obj)
            break
        }
    }
}


class DartMethodModel: NSObject {
    var isStatic = true
    var isFuture = true
    var notes = "/// "

    var name: String = ""

    var paramsType: String? = nil
    var paramsName: String? = nil

    var returnVal = ""
    var body = ""
    
    convenience init(isStatic: Bool,
                     isFuture: Bool,
                     notes: String = "/// ",
                     name: String,
                     paramsType: String? = nil,
                     paramsName: String? = nil,
                     returnVal: String = "",
                     body: String) {
        self.init()
        self.isStatic = isStatic
        self.isFuture = isFuture
        self.notes = notes
        self.name = name
        self.paramsType = paramsType
        self.paramsName = paramsName
        self.returnVal = returnVal
        self.body = body
    }
}


