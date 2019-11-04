//
//  NSView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSView+Helper.h"

@implementation NSView (Helper)

/**
 给所有自视图加框
 */
- (void)getViewLayer{
    NSArray *subviews = self.subviews;
    if (subviews.count == 0) return;
    for (NSView *subview in subviews) {
        subview.wantsLayer = true;
        subview.layer.borderWidth = 1.5;
        subview.layer.borderColor = NSColor.blueColor.CGColor;
//        subview.layer.borderColor = NSColor.clearColor.CGColor;
        
        [subview getViewLayer];
        
    }
}

+(__kindof NSButton*)createBtnRect:(CGRect)rect{
    assert([self isSubclassOfClass:NSButton.class]);
    
    NSButton * view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    view.bezelStyle = NSBezelStyleRegularSquare;
    return view;
}

+(__kindof NSImageView *)createImgViewRect:(CGRect)rect image:(id)image{
    assert([self isSubclassOfClass:NSImageView.class]);
    if (image) assert([image isKindOfClass:NSImage.class] || [image isKindOfClass:NSString.class]);
    
    NSImageView *view = [[self alloc] initWithFrame:rect];
    view.imageFrameStyle = NSImageFramePhoto;
    view.imageScaling = NSImageScaleNone;
    view.image = [image isKindOfClass:NSImage.class] ? image : [NSImage imageNamed:image];
    
    //图片内容对于ImageView内的位置
    view.imageAlignment = NSImageAlignCenter;
    //能否直接将图片拖到一个NSImageView类里
    view.editable = true;
    //能否对图片内容进行剪切、复制、粘贴行操作
    view.allowsCutCopyPaste = true;
    return view;
}

+(__kindof NSTextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder{
    assert([self isSubclassOfClass:NSTextField.class]);
    
    NSTextField *view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    view.font = [NSFont systemFontOfSize:15];
    view.textColor = NSColor.blackColor;
    
    view.bordered = false;  ///是否显示边框
    view.drawsBackground = true;
    
    view.cell.wraps = false;
    view.cell.scrollable = true;
    view.placeholderString = placeholder;
    
    return view;
}

+(__kindof NSTextView *)createTextViewRect:(CGRect)rect{
    assert([self isSubclassOfClass:NSTextView.class]);

    NSTextView * view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    view.horizontallyResizable = false;
    view.verticallyResizable = true;
    view.maxSize = CGSizeMake(FLT_MAX, FLT_MAX);
    view.textContainer.containerSize = NSMakeSize(FLT_MAX, FLT_MAX);
    view.textContainer.widthTracksTextView = true;
    
    view.selectable = true;
    view.drawsBackground = true;
    
    view.font = [NSFont systemFontOfSize:14];
    return view;
}

+(__kindof NSScrollView *)createScrollViewRect:(CGRect)rect{
    assert([self isSubclassOfClass:NSScrollView.class]);

    NSScrollView *view = [[self alloc] initWithFrame:rect];
//    view.backgroundColor = NSColor.redColor;
    view.drawsBackground = true;//不画背景（背景默认画成白色）
    view.hasHorizontalScroller = false;
    view.hasVerticalScroller = true;
    view.autohidesScrollers = YES;//自动隐藏滚动条（滚动的时候出现）
    return view;
}

+(__kindof NSTableView *)createTableViewRect:(CGRect)rect{
    assert([self isSubclassOfClass:NSTableView.class]);

    NSTableView *view = [[self alloc] initWithFrame:rect];
    view.gridStyleMask = NSTableViewSolidHorizontalGridLineMask;
    view.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
    view.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
    view.backgroundColor = NSColor.orangeColor;
    view.usesAlternatingRowBackgroundColors = YES; //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
//    view.gridColor = NSColor.redColor;
    view.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    view.headerView = nil;// 隐藏表头
    view.rowHeight = 70;

    return view;
}

+(__kindof NSTabView *)createTabViewRect:(CGRect)rect{
    assert([self isSubclassOfClass:NSTabView.class]);
    
    NSTabView *view = [[self alloc] initWithFrame:rect];
    view.tabPosition = NSTabPositionTop;
    view.tabViewBorderType = NSTabViewBorderTypeBezel;//边框样式：bezel类型边框
    
    return view;
}


@end
