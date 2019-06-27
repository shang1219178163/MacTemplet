//
//  BNGeneralConst.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNGeneralConst.h"

NSString * const kMainWindowFrame     =   @"kMainWindowFrame";

NSString * const kLanguageCN     =   @"zh-CN";
NSString * const kLanguageEN     =   @"en-US";

#pragma mark - - kSet

NSString * const kSetNumber      =   @"0123456789";
NSString * const kSetFloat       =   @"0123456789.";
NSString * const kSetAlpha       =   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
NSString * const kSetAlpha_Num   =   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
NSString * const kSetAlpha_Float =   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.";

#pragma mark - - kArr

NSString * const kArr_avg_float = @"@avg.floatValue";
NSString * const kArr_sum_inter = @"@sum.intValue";
NSString * const kArr_max_inter = @"@max.intValue";
NSString * const kArr_min_inter = @"@min.intValue";
NSString * const kArr_sum_float = @"@sum.floatValue";
NSString * const kArr_max_float = @"@max.floatValue";
NSString * const kArr_min_float = @"@min.floatValue";
NSString * const kArr_upper_list = @"uppercaseString";//大小写转换
NSString * const kArr_lower_list = @"lowercaseString";//大小写转换
NSString * const kArrs_unionDist_list = @"@distinctUnionOfArrays.self";//数组内部去重
NSString * const kArrs_union_list = @"@unionOfArrays.self";

#pragma mark - - File

const NSInteger kPageSize          = 20;
const NSInteger kFileSize_image    = 1*1024*1024;

//plist文件路径
NSString * const kPlistFilePath    = @"/Library/File_Plist/";
//plist文件名
NSString * const kPlistName_common = @"HuiZhuBang_common.plist";

#pragma mark - - kTag

const NSInteger kTAG_LABEL           = 100;
const NSInteger kTAG_BTN             = 200;
const NSInteger kTAG_BTN_RightItem   = 260;
const NSInteger kTAG_BTN_BackItem    = 261;

const NSInteger kTAG_IMGVIEW         = 300;
const NSInteger kTAG_TEXTFIELD       = 400;
const NSInteger kTAG_TEXTVIEW        = 500;
const NSInteger kTAG_ALERT_VIEW      = 600;
const NSInteger kTAG_ACTION_SHEET    = 700;
const NSInteger kTAG_PICKER_VIEW     = 800;
const NSInteger kTAG_DATE_PICKER     = 900;

const NSInteger kTAG_VIEW            = 1000;
const NSInteger kTAG_VIEW_Segment    = 1100;
const NSInteger kTAG_VIEW_RADIO      = 1200;
const NSInteger kTAG_VIEW_Picture    = 1300;

const NSInteger kTAG_UItableViewCell = 1500;

const NSInteger kTAG_ICAROUSEL       = 950;
const NSInteger kTAG_PAGE_CONTROL    = 951;

const NSInteger kComponent_0         = 0 ;
const NSInteger kComponent_1         = 1 ;
const NSInteger kComponent_2         = 2 ;

#pragma mark - -MacroGeometry与计算有关的尺寸属性

const CGFloat kStatusBarHeight      = 20;
const CGFloat kNaviBarHeight        = 44;
const CGFloat kTabBarHeight         = 49;
const CGFloat kPickerViewHeight     = 180;

const CGFloat kH_SegmentOfCustom    = 50;
const CGFloat kH_SegmentControl     = 44;

const CGFloat kH_searchBar          = 36;
const CGFloat kH_searchBarBackgroud = 56;

const CGFloat kH_topView            = 49;//itemsView高度
const CGFloat kH_slideView          = 5;//指示器高度
const CGFloat kH_CellHeight         = 60;

const CGFloat kX_GAP                = 15;
const CGFloat kY_GAP                = 10;
const CGFloat kPadding              = 8.0;

const CGFloat kW_LayerBorder        = 0.5;
const CGFloat kWH_ArrowRight        = 25;
const CGFloat kTimerValue           = 65;
const CGFloat kRatio_IDCard         = 1.58;
const CGFloat kRatio_LeftMenu       = 0.8;

const CGFloat kDurationShow         = 0.3;
const CGFloat kDurationDrop         = 0.5;
const CGFloat kDurationToast        = 1.0;

const CGFloat kW_item               = 80;
const CGFloat kW_progressView       = 130;

const CGFloat kH_LABEL              = 25;
const CGFloat kH_LABEL_TITLE        = 30;
const CGFloat kH_LABEL_SMALL        = 20;

const CGFloat kH_TEXTFIELD          = 30;
const CGFloat kH_LINE_VIEW          = 1/3.0;
const CGFloat kW_LINE_Vert          = 3.0;


#pragma mark - -font

const CGFloat kFontSize18 =  18;
const CGFloat kFontSize16 =  16;
const CGFloat kFontSize14 =  14;
const CGFloat kFontSize12 =  12;
const CGFloat kFontSize10 =  10;

#pragma mark - -视图

NSString * const kIMG_arrowRight           = @"img_arrowRight_gray";
NSString * const kIMG_arrowDown            = @"img_arrowDown_black";
NSString * const kIMG_arrowBack            = @"img_arrowLeft_white";
NSString * const kIMG_arrowUp              = @"img_arrowUp_blue";

NSString * const kIMG_portrait             = @"img_portrait_N";
NSString * const kIMG_portrait_N           = @"img_portrait_N";
NSString * const kIMG_portrait_H           = @"img_portrait_H";
NSString * const kIMG_pictureAdd           = @"img_pictureAdd";
NSString * const kIMG_pictureDelete        = @"img_pictureDelete";

NSString * const kIMG_defaultFailed        = @"img_failedDefault";
NSString * const kIMG_defaultFailed_S      = @"img_failedDefault_S";

NSString * const kIMG_sexBoy               = @"img_sex_boy";
NSString * const kIMG_sexGril              = @"img_sex_gril";

NSString * const kIMG_elemetDec            = @"img_elemet_decrease";
NSString * const kIMG_elemetInc            = @"img_elemet_increase";

NSString * const kIMG_scan                 = @"img_scan";
NSString * const kIMG_NFC                  = @"img_NFC";

NSString * const kIMG_inquiry              = @"img_dialog_inquiry";
NSString * const kIMG_update               = @"img_dialog_update";
NSString * const kIMG_warning              = @"img_dialog_warning";

NSString * const kIMG_notice               = @"img_notice";
NSString * const kIMG_location_H           = @"img_location_H";
NSString * const kIMG_more                 = @"img_more";

NSString * const kIMG_selected_NO          = @"btn_selected_NO";
NSString * const kIMG_selected_YES         = @"btn_selected_YES";
NSString * const kIMG_Add                  = @"btn_add";

NSString * const kIMG_like_H               = @"img_like_H";
NSString * const kIMG_like_W               = @"img_like_W";

NSString * const kMsg_NetWorkRequesting    = @"网络请求中...";
NSString * const kMsg_NetWorkFailed        = @"网络请求失败,请稍后再试";
NSString * const kMsg_NetWorkNodata        = @"暂无数据";
NSString * const kMsg_NetWorkNoMoredata    = @"没有更多数据了";
NSString * const kMsg_NetWorkFailed_Params = @"参数错误,请稍后再试";

NSString * const kMsg_Locationing          = @"定位中...";
NSString * const kMsg_LocationSuccess      = @"位置信息更新成功!";
NSString * const kMsg_LocationFailed       = @"定位失败,请稍后再试";
NSString * const kMsg_IDCardFailed         = @"身份证识别失败,请稍后再试";
NSString * const kMsg_IDCardSuccess        = @"身份证识别成功";


NSString * const kActionTitle_Know         = @"知道了";
NSString * const kActionTitle_Sure         = @"确定";
NSString * const kActionTitle_Cancell      = @"取消";
NSString * const kActionTitle_Delete       = @"删除";
NSString * const kActionTitle_Drop         = @"彻底删除";
NSString * const kActionTitle_Call         = @"呼叫";
NSString * const kActionTitle_Update       = @"立即升级";

NSString * const kActionTitle_Collect      = @"收藏";
NSString * const kActionTitle_Recover      = @"恢复";

NSString * const kNilText                  = @"--";
NSString * const kSeparateStr              = @",";
NSString * const kAsterisk                 = @"*";
NSString * const kBlankHalf                = @"  ";
NSString * const kBlankOne                 = @"    ";
NSString * const kBlankTwo                 = @"        ";
NSString * const kBlankFour                = @"                ";

#pragma mark - - 通用

NSString * const kDes_week                 =   @"星期一,星期二,星期三,星期四,星期五,星期六,星期天";
NSString * const kDes_month                =   @"正月, 二月, 三月, 四月, 五月, 六月, 七月, 八月,九月, 十月, 冬月, 腊月";
NSString * const kDes_day                  =   @"初一, 初二, 初三, 初四, 初五, 初六, 初七, 初八, 初九, 初十,十一, 十二, 十三, 十四, 十五, 十六, 十七, 十八, 十九, 二十, 廿一, 廿二, 廿三, 廿四, 廿五, 廿六, 廿七, 廿八, 廿九, 三十, 三十一";

NSString * const kItem_obj                 =   @"kItem_obj";
NSString * const kItem_objSeleted          =   @"kItem_objSeleted";
NSString * const kItem_block               =   @"kItem_block";

NSString * const kItem_title               =   @"kItem_title";
NSString * const kItem_titleColor          =   @"kItem_titleColor";
NSString * const kItem_textField           =   @"kItem_textField";

NSString * const kItem_titleSub            =   @"kItem_titleSub";
NSString * const kItem_titleSubColor       =   @"kItem_titleSubColor";
NSString * const kItem_titleSection        =   @"kItem_titleSection";

NSString * const kItem_image               =   @"kItem_image";
NSString * const kItem_image_H             =   @"kItem_image_H";

NSString * const kItem_controller          =   @"kItem_controller";
NSString * const kItem_controller_Title    =   @"kItem_controller_Title";
NSString * const kItem_Height              =   @"kItem_Height";

NSString * const kItem_dataList            =   @"kItem_dataList";
NSString * const kItem_finished            =   @"kItem_finish";

NSString * const kItem_header              =   @"kItem_header";
NSString * const kItem_footer              =   @"kItem_footer";

#pragma mark - -推送通知

NSString * const kNoti_title               = @"kNoti_title";
NSString * const kNoti_subtitle            = @"kNoti_subtitle";
NSString * const kNoti_body                = @"kNoti_body";
NSString * const kNoti_badge               = @"kNoti_badge";


#pragma mark - -通知

NSString * const kNotiPost_logIn           = @"kNotiPost_logIn";
NSString * const kNotiPost_logOut          = @"kNotiPost_logOut";
NSString * const kNotiPost_backgroudUploadLocation = @"kNotiPost_backgroudUploadLocation";

@implementation BNGeneralConst



@end
