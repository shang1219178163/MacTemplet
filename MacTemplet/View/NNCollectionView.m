//
//  NNCollectionView.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNCollectionView.h"

@interface NNCollectionView ()

@property (nonatomic, strong) NSScrollView *scrollView;

@end

@implementation NNCollectionView

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
}

#pragma mark -lazy

-(NSScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            NSScrollView *view = [[NSScrollView alloc] init];
            view.backgroundColor = NSColor.redColor;
            
            view.drawsBackground = false;//不画背景（背景默认画成白色）
            view.hasHorizontalScroller = true;
            view.hasVerticalScroller = true;
            view.autohidesScrollers = YES;//自动隐藏滚动条（滚动的时候出现）
            view;
        });
    }
    return _scrollView;
}

@end

