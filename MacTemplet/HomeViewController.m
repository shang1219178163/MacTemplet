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

<<<<<<< HEAD
=======
NSString *const kDefaultsClassPrefix = @"keyClassPrefix";
NSString *const kDefaultsRootClassName = @"kDefaultsRootClassName";

NSString *const kDefaultsSwift = @"keySwift";
NSString *const kDefaultsPodName = @"keyPodName";

>>>>>>> parent of 6cc0a40... update
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
    
<<<<<<< HEAD
    NSString * folderPath = @"/Users/shang/Downloads";
    [NSUserDefaults.standardUserDefaults setObject:folderPath forKey:kFolderPath];

    [NSUserDefaults.standardUserDefaults setObject:@"BN" forKey:kClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:@"NSObject" forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults setBool:false forKey:kIsSwift];
    [NSUserDefaults.standardUserDefaults setBool:true forKey:kIsYYModel];

    [NSUserDefaults.standardUserDefaults synchronize];
    
=======
//    [self.scrollView scrollToTop];

>>>>>>> parent of 6cc0a40... update
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
        make.width.equalTo(120);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.textField.right).offset(gap);
        make.width.equalTo(120);
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
<<<<<<< HEAD
//    DDLog(@"%@",textField.stringValue);
 
=======
    DDLog(@"%@",textField.stringValue);
>>>>>>> parent of 6cc0a40... update
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    NSTextField *textField = (NSTextField *)obj.object;
//    DDLog(@"%@",textField.stringValue);
    
<<<<<<< HEAD
    if (textField == self.textField || textField == self.textFieldTwo) {
        NSString * defaultsKey = (textField == self.textField) ? kClassPrefix : kSuperClass;
        [NSUserDefaults.standardUserDefaults setObject:textField.stringValue forKey:defaultsKey];
        [NSUserDefaults.standardUserDefaults synchronize];
        
=======
    if (textField == self.textField) {
        [NSUserDefaults setObject:textField.stringValue forKey:kDefaultsClassPrefix];

    }
    else if (textField == self.textFieldTwo) {
        [NSUserDefaults setObject:textField.stringValue forKey:kDefaultsRootClassName];

>>>>>>> parent of 6cc0a40... update
    }
    else {
        DDLog(@"未知错误:%@",textField);
    }
}
//
//- (void)hanldeAction:(NSButton *)sender{
//    NSLog(@"%@", sender);
//}

<<<<<<< HEAD
#pragma mark -funtions

- (void)readFile{
    NSString *path = [NSBundle.mainBundle pathForResource:@"appinfo" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    id obj = content.objValue;
//    DDLog(@"%@", obj);
    
    self.textView.string = [(NSDictionary *)obj jsonString];
}

- (void)clearFileOutputPath {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kFolderPath];
    [NSUserDefaults.standardUserDefaults synchronize];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"\nClear Success.";
    [alert runModal];
    
}

- (void)hanldeJson{
    self.hTextView.string = @"";
    self.mTextView.string = @"";
    
    id result = self.textView.string.objValue;
    if (!result) {
        NSError *error = [NSError errorWithDomain:@"Error：Json is invalid" code:3840 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        NSLog(@"Error：Json is invalid");
        
        return;
    }
    ESClassInfo *classInfo = [self dealClassNameWithJsonResult:result];
    [self outputResult:classInfo];
    
}

#pragma mark - Change ESJsonFormat
/**
 *  初始类名，RootClass/JSON为数组/创建文件与否
 *
 *  @param result JSON转成字典或者数组
 *
 *  @return 类信息
 */
- (ESClassInfo *)dealClassNameWithJsonResult:(id)result{
    __block ESClassInfo *classInfo = nil;
    //如果当前是JSON对应是字典
    if ([result isKindOfClass:[NSDictionary class]]) {
        //如果是生成到文件
        NSString *className = [[NSUserDefaults objectForKey:kClassPrefix] stringByAppendingString:ESRootClassName];
        classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:result];
        if ([NSUserDefaults.standardUserDefaults boolForKey:kIsSwift]) {
            self.hFilename = [NSString stringWithFormat:@"%@.swift",className];
            self.mFilename = @"";

        } else {
            self.hFilename = [NSString stringWithFormat:@"%@.h",className];
            self.mFilename = [NSString stringWithFormat:@"%@.m",className];

        }
        [self dealPropertyNameWithClassInfo:classInfo];
     
    } else if ([result isKindOfClass:[NSArray class]]){
        //当前是JSON代表数组
        NSString *className = [[NSUserDefaults objectForKey:kClassPrefix] stringByAppendingString:ESRootClassName];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:className];
        classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:dic];
        
        [self dealPropertyNameWithClassInfo:classInfo];
    
    }
    return classInfo;
}


/**
 *  处理属性名字(用户输入属性对应字典对应类或者集合里面对应类的名字)
 *
 *  @param classInfo 要处理的ClassInfo
 *
 *  @return 处理完毕的ClassInfo
 */
- (ESClassInfo *)dealPropertyNameWithClassInfo:(ESClassInfo *)classInfo{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:classInfo.classDic];
    for (NSString *key in dic) {
        //取出的可能是NSDictionary或者NSArray
        id obj = dic[key];
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {

            NSString *msg = [NSString stringWithFormat:@"The '%@' correspond class name is:",key];
            if ([obj isKindOfClass:[NSArray class]]) {
                //May be 'NSString'，will crash
                if (!([[obj firstObject] isKindOfClass:[NSDictionary class]] || [[obj firstObject] isKindOfClass:[NSArray class]])) {
                    continue;
                }
                msg = [NSString stringWithFormat:@"The '%@' child items class name is:",key];
            }
//            __block NSString *childClassName = [key capitalizedString];
            __block NSString *childClassName = [[NSUserDefaults.standardUserDefaults objectForKey:kClassPrefix] stringByAppendingString: key.capitalizedString];
            if (![childClassName containsString:@"Model"]) {
                childClassName = [childClassName stringByAppendingString:@"Model"];
            }
            
            //如果当前obj是 NSDictionary 或者 NSArray，继续向下遍历
            if ([obj isKindOfClass:[NSDictionary class]]) {
                ESClassInfo *childClassInfo = [[ESClassInfo alloc] initWithClassNameKey:key ClassName:childClassName classDic:obj];
                [self dealPropertyNameWithClassInfo:childClassInfo];
                //设置classInfo里面属性对应class
                [classInfo.propertyClassDic setObject:childClassInfo forKey:key];
            }else if([obj isKindOfClass:[NSArray class]]){
                //如果是 NSArray 取出第一个元素向下遍历
                NSArray *array = obj;
                if (array.firstObject) {
                    NSObject *obj = array.firstObject;
                    //May be 'NSString'，will crash
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        ESClassInfo *childClassInfo = [[ESClassInfo alloc] initWithClassNameKey:key ClassName:childClassName classDic:(NSDictionary *)obj];
                        [self dealPropertyNameWithClassInfo:childClassInfo];
                        //设置classInfo里面属性类型为 NSArray 情况下，NSArray 内部元素类型的对应的class
                        [classInfo.propertyArrayDic setObject:childClassInfo forKey:key];
                    }
                }
            }
        }
    }
    return classInfo;
}

-(void)outputResult:(ESClassInfo*)classInfo{
    
    if (![NSUserDefaults.standardUserDefaults valueForKey:kFolderPath]) {
        //选择保存路径
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        if ([panel runModal] == NSModalResponseOK) {
            NSString *folderPath = [panel.URLs.firstObject relativePath];
            [classInfo createFileWithFolderPath:folderPath];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
        
    } else {
        if (!self.hTextView) return;
        if (!kIsSwift) {
            NSString *mContent = [NSString stringWithFormat:@"%@\n%@",classInfo.classContentForM,classInfo.classInsertTextViewContentForM];
            self.mTextView.string = mContent;
            
            NSString * hContent = [NSString stringWithFormat:@"%@\n%@\n%@",classInfo.atClassContent, classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
            self.hTextView.string = hContent;
            
        } else {
            NSString * hContent = [NSString stringWithFormat:@"%@\n\n%@",classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
            self.hTextView.string = hContent;
        
        }
        
        [self creatFile];
    }
}

- (void)creatFile{
    NSString *folderPath = [NSUserDefaults.standardUserDefaults valueForKey:kFolderPath];
    if (folderPath) {
        [FileManager.sharedInstance handleBaseData:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
        [NSWorkspace.sharedWorkspace openFile:folderPath];
        
    } else {
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];

        if (panel.runModal == NSModalResponseOK) {
            folderPath = [panel.URLs.firstObject relativePath];
            [NSUserDefaults.standardUserDefaults setValue:folderPath forKey:kFolderPath];
            NSLog(@"%@",folderPath);
            [FileManager.sharedInstance handleBaseData:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
    }
}


=======
>>>>>>> parent of 6cc0a40... update
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
            view.bordered = true;  ///是否显示边框
            
            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view.font = [NSFont systemFontOfSize:14];

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
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
            view.bordered = true;  ///是否显示边框

            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view.font = [NSFont systemFontOfSize:14];

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
                
<<<<<<< HEAD
                BOOL isSwift = (sender.selectedSegment == 0) ? YES : NO;
                [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
                [NSUserDefaults.standardUserDefaults synchronize];
                
                [self clearFileOutputPath];
=======
                [NSUserDefaults setObject:@(sender.selectedSegment) forKey:kDefaultsSwift];
>>>>>>> parent of 6cc0a40... update

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
                [NSUserDefaults setObject:sender.titleOfSelectedItem forKey:kPodName];

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

<<<<<<< HEAD
- (BOOL)isSwift{
    return [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
}

=======
>>>>>>> parent of 6cc0a40... update
@end
