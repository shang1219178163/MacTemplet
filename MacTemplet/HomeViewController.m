//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"
#import "NNTextView.h"
#import "NNTextField.h"

NSString *const kDefaultsClassPrefix = @"keyClassPrefix";
NSString *const kDefaultsRootClassName = @"kDefaultsRootClassName";

NSString *const kDefaultsSwift = @"keySwift";
NSString *const kDefaultsPodName = @"keyPodName";

@interface HomeViewController ()<NSTextViewDelegate, NSTextFieldDelegate, NSTextDelegate>

@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTextView *textViewTwo;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *textFieldTwo;

@property (nonatomic, strong) NSSegmentedControl *segmentCtl;

@property (nonatomic, strong) NSPopUpButton *popBtn;
@property (nonatomic, strong) NSButton *btn;

@property (nonatomic, strong) NSArray *list;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title = @"Home";
    
    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.textViewTwo.enclosingScrollView];
    
    [self.bottomView addSubview:self.textField];
    [self.bottomView addSubview:self.textFieldTwo];
    [self.bottomView addSubview:self.btn];
    [self.bottomView addSubview:self.popBtn];
    [self.bottomView addSubview:self.segmentCtl];
    [self.view addSubview:self.bottomView];

    
    self.list = @[self.textView.enclosingScrollView, self.textViewTwo.enclosingScrollView];

//    self.textView.string = @"---有问题的NSTextView---\n\n第一杯酒，阳光明媚，窗外的青藤爬进了我的眼。\n第二杯酒，春风轻漾，叶梢轻拂着我的眉。\n第三杯酒，鸟儿鸣叫，轻啄着我的心。\n第四杯酒，影上窗楣，让我忘了我是谁。\n第五杯酒，少年将飞，穿越层林叠翠。\n第六杯酒，十六轻狂，笑斥天下执念。\n第七杯酒，人上心头，紫衣白裙小马尾。\n第八杯酒，月光轻舞，你的脸儿红云飘。\n第九杯酒，大漠孤烟，未知的前程孤独的脚印。\n第十杯酒，长河旭日，谁家孩儿无齿地笑。\n十一杯酒，群山苍翠，有个老翁枕石而醉。\n十二杯酒，临渊而窥，山崖还给年岁。\n十三杯酒，蜗牛有角，彼世界如此世界一般疲惫。\n十四杯酒，迷眼渐累，火堆旁的人们渐要沉睡。\n十五杯酒，形只影单，远方的人儿可曾安睡。\n十六杯酒，抬头望月，白衣白裙与白兔。\n十七杯酒，漫天星星，谁真谁幻谁在乎。\n十八杯酒，残酒映月，谁的容颜依稀浮现。\n十九杯酒，仰天长啸，该死的老天操蛋的命运。\n二十杯酒，闭了双眼，是是非非皆已不见。\n二十一杯酒，想起妹妹，你的虎牙为谁而笑。\n二十二杯酒，我的弟弟，是否忙着拯救地球。\n二十三杯酒，想起妈妈，你的头发烤面包啦。\n二十四杯酒，我的朋友，天堂的你可曾安好。\n二十五杯酒，想起父亲，窗外的雨点坠了下来。\n二十六杯酒，乌蝇不飞，若心悸的你我躲在叶下看秋雨渐衰。\n二十七杯酒，弹几点泪，轻轻放下酒杯。\n......";
    
    self.textView.string = @"       美国、日本、英国、法国作为发达国家的典型代表，均建立起了完善的现代税制体系。目前，个人所得税和社会保障税是四国的主要税种，合计占比高达50%左右；企业所得税在四国税收收入中占比不高，只有日本超过了10%；英法增值税占比较高，美国无增值税。需要注意的是，中日两国消费税存在较大差异。我国的消费税是在已经对商品普遍征收增值税的基础上，选择少数消费品再征收的一个税种，类似于“奢侈品税”或“环境损害补偿税”，占比较低。日本的消费税是对除土地交易和房屋出租以外的一切商品和服务贸易征收，类似于国内的增值税，占比较高。美国、日本、英国、法国作为发达国家的典型代表，均建立起了完善的现代税制体系。目前，个人所得税和社会保障税是四国的主要税种，合计占比高达50%左右；企业所得税在四国税收收入中占比不高，只有日本超过了10%；英法增值税占比较高，美国无增值税。需要注意的是，中日两国消费税存在较大差异。我国的消费税是在已经对商品普遍征收增值税的基础上，选择少数消费品再征收的一个税种，类似于“奢侈品税”或“环境损害补偿税”，占比较低。日本的消费税是对除土地交易和房屋出租以外的一切商品和服务贸易征收，类似于国内的增值税，占比较高。美国、日本、英国、法国作为发达国家的典型代表，均建立起了完善的现代税制体系。目前，个人所得税和社会保障税是四国的主要税种，合计占比高达50%左右；企业所得税在四国税收收入中占比不高，只有日本超过了10%；英法增值税占比较高，美国无增值税。需要注意的是，中日两国消费税存在较大差异。我国的消费税是在已经对商品普遍征收增值税的基础上，选择少数消费品再征收的一个税种，类似于“奢侈品税”或“环境损害补偿税”，占比较低。日本的消费税是对除土地交易和房屋出租以外的一切商品和服务贸易征收，类似于国内的增值税，占比较高。美国、日本、英国、法国作为发达国家的典型代表，均建立起了完善的现代税制体系。目前，个人所得税和社会保障税是四国的主要税种，合计占比高达50%左右；企业所得税在四国税收收入中占比不高，只有日本超过了10%；英法增值税占比较高，美国无增值税。需要注意的是，中日两国消费税存在较大差异。我国的消费税是在已经对商品普遍征收增值税的基础上，选择少数消费品再征收的一个税种，类似于“奢侈品税”或“环境损害补偿税”，占比较低。日本的消费税是对除土地交易和房屋出租以外的一切商品和服务贸易征收，类似于国内的增值税，占比较高。=====";
//    [self.view getViewLayer];
    
    
}

-(void)viewDidAppear{
    [super viewDidAppear];
    
//    [self.scrollView scrollToTop];

}

-(void)viewDidLayout{
    [super viewDidLayout];
    
    CGFloat padding = 8;
    CGFloat gap = 15;
    
    //水平方向控件间隔固定等间隔
    [self.list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:gap leadSpacing:0 tailSpacing:0];
    [self.list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.superview);
        make.bottom.equalTo(self.textView.enclosingScrollView.superview).offset(-55);
    }];
    
//    [self.textView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollView);
//    }];
//
//    
//    [self.textViewTwo makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollViewTwo);
//    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.bottom).offset(padding);
        make.left.right.equalTo(self.bottomView.superview);
        make.bottom.equalTo(self.bottomView.superview);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.bottomView.superview).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.textField.right).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.bottomView.superview).offset(-gap);
        make.width.equalTo(80);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.popBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.btn.left).offset(-gap);
        make.width.equalTo(120);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.popBtn.left).offset(-gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
}

#pragma mark -funtions

- (void)textDidChange:(NSNotification *)notification{
    NSTextView * view = notification.object;
    NSLog(@"length:%@", @(view.string.length));
    NSLog(@"containerSize:%@", @(view.textContainer.containerSize));
//    [view scrollRangeToVisible: NSMakeRange(FLT_MAX, FLT_MAX)];
}

- (void)textDidEndEditing:(NSNotification *)notification{
    
    
}


#pragma mark -funtions

- (void)controlTextDidChange:(NSNotification *)obj {
    // You can get the NSTextField, which is calling the method, through the userInfo dictionary.
    NSTextField *textField = (NSTextField *)obj.object;
    DDLog(@"%@",textField.stringValue);
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    NSTextField *textField = (NSTextField *)obj.object;
    DDLog(@"%@",textField.stringValue);
    
    if (textField == self.textField) {
        [NSUserDefaults setObject:textField.stringValue forKey:kDefaultsClassPrefix];

    }
    else if (textField == self.textFieldTwo) {
        [NSUserDefaults setObject:textField.stringValue forKey:kDefaultsRootClassName];

    }
    else {
        DDLog(@"未知错误:%@",textField);
    }
}
//
//- (void)hanldeAction:(NSButton *)sender{
//    NSLog(@"%@", sender);
//}

#pragma mark -lazy


-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.delegate = self;
            view.string = @"NSScrollView上无法滚动的NSTextView";
            view;
        });
    }
    return _textView;
}

-(NNTextView *)textViewTwo{
    if (!_textViewTwo) {
        _textViewTwo = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.editable = false;
            view.delegate = self;

            view;
        });
    }
    return _textViewTwo;
}

-(NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView *view = [[NNView alloc]init];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            
            view;
        });
    }
    return _bottomView;
}

-(NNTextField *)textField{
    if (!_textField) {
        _textField = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Class Prefix"];
            view.editable = true;  ///是否可编辑
            view.bordered = true;  ///是否显示边框
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view.delegate = self;
            
            view;
        });
    }
    return _textField;
}

-(NNTextField *)textFieldTwo{
    if (!_textFieldTwo) {
        _textFieldTwo = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Root Class name"];
            view.editable = true;  ///是否可编辑
            view.bordered = true;  ///是否显示边框

            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;

            view.delegate = self;
            
            view;
        });
    }
    return _textFieldTwo;
}

-(NSSegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        _segmentCtl = ({
            NSArray *items = @[@"Swift", @"OC"];
            NSSegmentedControl * view = [[NSSegmentedControl alloc] init];
            view.items = items;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSSegmentedControl *sender = (NSSegmentedControl *)control;
                NSLog(@"%@", @(sender.selectedSegment));
                
                [NSUserDefaults setObject:@(sender.selectedSegment) forKey:kDefaultsSwift];

            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _segmentCtl;
}

- (NSPopUpButton *)popBtn{
    if (!_popBtn) {
        _popBtn = ({
            NSPopUpButton *view = [[NSPopUpButton alloc] initWithFrame:CGRectZero pullsDown:false];
            view.autoenablesItems = true;
            
            NSArray *list = @[@"北京", @"上海", @"广州", @"深圳"];
            [view addItemsWithTitles:list];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSPopUpButton *sender = (NSPopUpButton *)control;
                NSLog(@"%@", sender.titleOfSelectedItem);
                [NSUserDefaults setObject:sender.titleOfSelectedItem forKey:kDefaultsPodName];

            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _popBtn;
}

-(NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton *view = [[NSButton alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            view.bezelStyle = NSBezelStyleRounded;
            
            view.title = @"保存";
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSLog(@"%@", control);
                NSLog(@"%@", self.textField.stringValue);

            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _btn;
}

@end
