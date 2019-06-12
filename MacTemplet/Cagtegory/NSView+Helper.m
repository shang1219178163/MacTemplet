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
//        subview.layer.borderColor = UIColor.clearColor.CGColor;
        
        [subview getViewLayer];
        
    }
}

+(NSImageView *)createImgViewRect:(CGRect)rect image:(id)image{
    assert([image isKindOfClass:NSImage.class] || [image isKindOfClass:NSString.class]);
    NSImageView *view = [[NSImageView alloc] init];
    view.frame = rect;
    
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

+(NSTextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder{
    NSTextField *view = [[NSTextField alloc]init];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    view.bordered = false;  ///是否显示边框
    view.textColor = NSColor.blackColor;
    view.alignment = NSTextAlignmentCenter;
    
    view.drawsBackground = true;
    view.font = [NSFont systemFontOfSize:15];
    view.cell.wraps = false;
    view.cell.scrollable = true;
    view.placeholderString = placeholder;
    view.stringValue = text;

    return view;

}

+(NSTextView *)createTextViewRect:(CGRect)rect text:(NSString *)text{
    NSTextView * view = [[NSTextView alloc]init];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    view.horizontallyResizable = false;
    view.verticallyResizable = true;
    view.maxSize = CGSizeMake(FLT_MAX, FLT_MAX);
    view.textContainer.containerSize = NSMakeSize(FLT_MAX, FLT_MAX);
    view.textContainer.widthTracksTextView = true;
    
    view.selectable = true;
    view.drawsBackground = true;
    
    view.font = [NSFont systemFontOfSize:15];
    view.string = text;
    return view;
}

+(NSScrollView *)createScrollViewRect:(CGRect)rect{
    NSScrollView *view = [[NSScrollView alloc] init];
    view.frame = rect;
    view.backgroundColor = NSColor.redColor;
    
    view.drawsBackground = false;//不画背景（背景默认画成白色）
    view.hasHorizontalScroller = true;
    view.hasVerticalScroller = true;
    view.autohidesScrollers = YES;//自动隐藏滚动条（滚动的时候出现）
    return view;
}

+(NSTableView *)createTableViewRect:(CGRect)rect{
    NSTableView *view = [[NSTableView alloc] init];
    view.frame = rect;
    view.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
    view.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
    view.backgroundColor = NSColor.orangeColor;
    view.usesAlternatingRowBackgroundColors = YES; //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
    view.gridColor = NSColor.redColor;
    return view;
}
@end
