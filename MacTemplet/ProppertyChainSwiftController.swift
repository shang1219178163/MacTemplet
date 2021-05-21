//
//  ProppertyChainSwiftController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/4/22.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

import RxSwift
import RxCocoa

@objcMembers class ProppertyChainSwiftController: NSViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = "";
        
        return view
    }()

    lazy var textViewOne: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        
        return view
    }()
    
    lazy var textField: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "var Prefix")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()
    
    
    lazy var textFieldOne: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "class")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()
    
    lazy var textFieldTwo: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "var Suffix")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()

    lazy var btn: NSButton = {
        let view: NSButton = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .rounded
        view.title = "Done"

        view.addActionHandler { (sender) in
            NSApp.mainWindow!.makeFirstResponder(nil)
            self.createFiles()
        }
        return view
    }()
    
    lazy var btnRefresh: NSButton = {
        let view: NSButton = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .rounded
        view.title = "刷新一下"

        view.addActionHandler { (sender) in
            NSApp.mainWindow!.makeFirstResponder(nil)
            self.convertContent()
        }
        return view
    }()
    
    
    var propertyPrefix = "nn_"
    var propertySuffix = "Chain"

    var propertyClass = "NSObject"
    var propertyClassAvailableDes = ""

    var hContent = ""
    var mContent = ""

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(textView.enclosingScrollView!)
        view.addSubview(textViewOne.enclosingScrollView!)
        view.addSubview(textField)
        view.addSubview(textFieldOne)
        view.addSubview(textFieldTwo)
        view.addSubview(btn)
        view.addSubview(btnRefresh)

        NoodleLineNumberView.setupLineNumber(with: textView)
        
        textView.rxDrive { (value) in
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textField.rxDrive { (value) in
            self.propertyPrefix = value
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textFieldOne.rxDrive { (value) in
            self.propertyClass = value
            self.convertContent()
        }.disposed(by: disposeBag)
        
        
        textField.stringValue = propertyPrefix
        textFieldOne.stringValue = propertyClass
        textFieldTwo.stringValue = propertySuffix

        textView.string = kContentFlowLayout
        
        textView.string = kContentURLComponents
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let items = [textView.enclosingScrollView!, textViewOne.enclosingScrollView!]
        items.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 15, leadSpacing: 0, tailSpacing: 0)
        items.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(-45);
        }
        
        btn.snp.makeConstraints { (make) in
//            make.top.equalTo(textField).offset(5)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-kPadding)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        btnRefresh.snp.makeConstraints { (make) in
//            make.top.equalTo(textField).offset(5)
            make.right.equalTo(btn.snp.left).offset(-10)
            make.bottom.width.height.equalTo(btn)
        }
                
        textField.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10);
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        textFieldOne.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalTo(textField.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }

        textFieldTwo.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalTo(textFieldOne.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    
    }
    // MARK: -funtions
    func convertContent() {
        propertyPrefix = textField.stringValue
        propertySuffix = textFieldTwo.stringValue

        let text = textView.string
        if (text as NSString).range(of: "class").location != NSNotFound
            && (text as NSString).range(of: " : ").location != NSNotFound {
            let range = (text as NSString).range(of: "class")
            propertyClass = text.substringFrom(range.location + range.length).components(separatedBy: " : ").first!.trimmed
//            DDLog(propertyClass)
        } else if (text as NSString).range(of: "struct").location != NSNotFound
            && (text as NSString).range(of: " : ").location != NSNotFound {
            let range = (text as NSString).range(of: "struct")
            propertyClass = text.substringFrom(range.location + range.length).components(separatedBy: " : ").first!.trimmed
//            DDLog(propertyClass)
        }
        
        if text.trimmed.hasPrefix("@available(") && text.trimmed.contains(")") {
            if let range = text.range(of: ")") {
                propertyClassAvailableDes = String(text[text.startIndex..<range.upperBound])
            }
        }
                
        var hPropertys = ""
        let propertys = NNPropertySwiftModel.models(with: text)
        propertys.forEach { (model) in
            model.namePrefix = propertyPrefix
            model.nameSuffix = propertySuffix
            model.classType = propertyClass
            hPropertys += model.chainContent + "\n\n"
        }
        
        hContent = fileContent(propertyClass, chainContentH: hPropertys)
//        textViewOne.string = hContent + "\n" + mContent
        textViewOne.string =
"""
\(hContent)
"""

        textFieldOne.stringValue = propertyClass
    }
    
    func createFiles() {
        if hContent == "" {
            convertContent()
        }
        FileManager.createFile(content: hContent, name: "\(propertyClass)+Chain", type: "swift")
    }
    
    ///创建文本内容
    func fileContent(_ classType: String, chainContentH: String) -> String {
        let copyRight = NSApplication.copyright(with: "\(classType)+Chain", type: "h")
        
        let result =
"""
\(copyRight)

\(propertyClassAvailableDes)
public extension \(classType) {

\(chainContentH)
}
"""
        return result
    }
    
}



let kContentFlowLayout = """
@available(iOS 6.0, *)
open class UICollectionViewFlowLayout : UICollectionViewLayout {


open var minimumLineSpacing: CGFloat

open var minimumInteritemSpacing: CGFloat

open var itemSize: CGSize

@available(iOS 8.0, *)
open var estimatedItemSize: CGSize // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:

open var scrollDirection: UICollectionView.ScrollDirection // default is UICollectionViewScrollDirectionVertical

open var headerReferenceSize: CGSize

open var footerReferenceSize: CGSize

open var sectionInset: UIEdgeInsets


/// The reference boundary that the section insets will be defined as relative to. Defaults to `.fromContentInset`.
/// NOTE: Content inset will always be respected at a minimum. For example, if the sectionInsetReference equals `.fromSafeArea`, but the adjusted content inset is greater that the combination of the safe area and section insets, then section content will be aligned with the content inset instead.
@available(iOS 11.0, *)
open var sectionInsetReference: UICollectionViewFlowLayout.SectionInsetReference


// Set these properties to YES to get headers that pin to the top of the screen and footers that pin to the bottom while scrolling (similar to UITableView).
@available(iOS 9.0, *)
open var sectionHeadersPinToVisibleBounds: Bool

@available(iOS 9.0, *)
open var sectionFootersPinToVisibleBounds: Bool
}
"""

let kContentLabel = """
@available(iOS 2.0, *)
open class UILabel : UIView, NSCoding, UIContentSizeCategoryAdjusting {


open var text: String? // default is nil

open var font: UIFont! // default is nil (system font 17 plain)

open var textColor: UIColor! // default is labelColor

open var shadowColor: UIColor? // default is nil (no shadow)

open var shadowOffset: CGSize // default is CGSizeMake(0, -1) -- a top shadow

open var textAlignment: NSTextAlignment // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)

open var lineBreakMode: NSLineBreakMode // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text


// the underlying attributed string drawn by the label, if set, the label ignores the properties above.
@available(iOS 6.0, *)
@NSCopying open var attributedText: NSAttributedString? // default is nil


// the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property

open var highlightedTextColor: UIColor? // default is nil

open var isHighlighted: Bool // default is NO


open var isUserInteractionEnabled: Bool // default is NO

open var isEnabled: Bool // default is YES. changes how the label is drawn


// this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
// if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
// truncated using the line break mode.

open var numberOfLines: Int


// these next 3 properties allow the label to be autosized to fit a certain width by scaling the font size(s) by a scaling factor >= the minimum scaling factor
// and to specify how the text baseline moves when it needs to shrink the font.

open var adjustsFontSizeToFitWidth: Bool // default is NO

open var baselineAdjustment: UIBaselineAdjustment // default is UIBaselineAdjustmentAlignBaselines

@available(iOS 6.0, *)
open var minimumScaleFactor: CGFloat // default is 0.0


// Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
// The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
@available(iOS 9.0, *)
open var allowsDefaultTighteningForTruncation: Bool // default is NO


// Specifies the line break strategies that may be used for laying out the text in this label.
// If this property is not set, the default value is NSLineBreakStrategyStandard.
// If the label contains an attributed text with paragraph style(s) that specify a set of line break strategies, the set of strategies in the paragraph style(s) will be used instead of the set of strategies defined by this property.
open var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy


// override points. can adjust rect before calling super.
// label has default content mode of UIViewContentModeRedraw

open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect

open func drawText(in rect: CGRect)


// Support for constraint-based layout (auto layout)
// If nonzero, this is used when determining -intrinsicContentSize for multiline labels
@available(iOS 6.0, *)
open var preferredMaxLayoutWidth: CGFloat
}
"""

let kContentButton = """
@available(iOS 2.0, *)
open class UIButton : UIControl, NSCoding {
/// An optional menu for the button to display. The button will automatically enable or disable its contextMenuInteraction when a non-nil or nil menu is set. Defaults to nil.


@available(iOS 6.0, *)
open var typingAttributes: [NSAttributedString.Key : Any] // automatically resets when the selection changes

}
"""


let kContentURLComponents = """
public struct URLComponents : ReferenceConvertible, Hashable, Equatable {

    public var scheme: String?

    public var user: String?

    public var password: String?

    public var host: String?

    public var port: Int?

    public var path: String

    public var query: String?

    public var fragment: String?

    public var percentEncodedUser: String?

    public var percentEncodedPassword: String?

    public var percentEncodedHost: String?

    public var percentEncodedPath: String

    public var percentEncodedQuery: String?

    public var percentEncodedFragment: String?
}
"""
