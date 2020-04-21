//
//  NNTextView.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTextView.h"

@interface NNTextView ()

@property (nonatomic, strong) NSScrollView *scrollView;
//static NSAttributedString *placeHolderString;

@end

@implementation NNTextView

//+ (void)initialize{
//    if (self == [NNTextView class]) {
//        static BOOL initialized = NO;
//        if (!initialized) {
//
//            NSDictionary *attDic = @{NSForegroundColorAttributeName: NSColor.grayColor};
//            placeHolderString = [[NSAttributedString alloc] initWithString:@"发送消息..." attributes:attDic];
//        }
//    }
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.scrollView.documentView = self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if ([self.string isEqualToString:@""] && self != self.window.firstResponder && self.placeHolder) {
        NSDictionary *attDic = @{NSForegroundColorAttributeName: NSColor.grayColor};
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.placeHolder attributes:attDic];
        [attString drawAtPoint:NSMakePoint(4, 0)];
    }
}

- (BOOL)resignFirstResponder{
    [self setNeedsDisplay:YES];
    return [super resignFirstResponder];
}


#pragma mark -lazy

-(NSScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            NSScrollView *view = [[NSScrollView alloc] init];
            view.backgroundColor = NSColor.whiteColor;
            
            view.drawsBackground = false;//不画背景（背景默认画成白色）
            view.hasHorizontalScroller = false;
            view.hasVerticalScroller = true;
            view.autohidesScrollers = YES;//自动隐藏滚动条（滚动的时候出现）
            view;
        });
    }
    return _scrollView;
}

@end

