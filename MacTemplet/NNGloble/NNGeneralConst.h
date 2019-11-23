//
//  NNGeneralConst.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NSTableCellView *(^BlockCellForRow)(NSTableView *tableView, NSIndexPath *indexPath);
typedef void(^BlockDidSelectRow)(NSTableView *tableView, NSIndexPath *indexPath);

/// 主窗口位置大小
FOUNDATION_EXPORT NSString * const kMainWindowFrame ;

#pragma mark - - kLanguage
/// 中文
FOUNDATION_EXPORT NSString * const kLanguageCN ;
/// 英文
FOUNDATION_EXPORT NSString * const kLanguageEN ;

#pragma mark - - kSet
/// 0123456789
FOUNDATION_EXPORT NSString * const kSetNumber ;
/// 0123456789.
FOUNDATION_EXPORT NSString * const kSetFloat ;
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
FOUNDATION_EXPORT NSString * const kSetAlpha ;
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
FOUNDATION_EXPORT NSString * const kSetAlpha_Num ;
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.
FOUNDATION_EXPORT NSString * const kSetAlpha_Float ;


#pragma mark - - kArr
/// avg.floatValue
FOUNDATION_EXPORT NSString * const kArrAvg_float ;
/// sum.floatValue
FOUNDATION_EXPORT NSString * const kArrSum_float ;
/// sum.intValue
FOUNDATION_EXPORT NSString * const kArrSum_inter ;
/// max.floatValue
FOUNDATION_EXPORT NSString * const kArrMax_float ;
/// max.intValue
FOUNDATION_EXPORT NSString * const kArrMax_inter ;
/// min.floatValue
FOUNDATION_EXPORT NSString * const kArrMin_float ;
/// min.intValue
FOUNDATION_EXPORT NSString * const kArrMin_inter ;
/// uppercaseString
FOUNDATION_EXPORT NSString * const kArrUpper_list ;
/// lowercaseString
FOUNDATION_EXPORT NSString * const kArrLower_list ;
/// distinctUnionOfArrays.self(数组内部去重)
FOUNDATION_EXPORT NSString * const kArrsUnionDist_list ;
/// unionOfArrays.self
FOUNDATION_EXPORT NSString * const kArrsUnion_list ;

#pragma mark - - date

/// 60s
FOUNDATION_EXPORT const NSInteger kDate_minute ;
/// 3600s
FOUNDATION_EXPORT const NSInteger kDate_hour ;
/// 86400
FOUNDATION_EXPORT const NSInteger kDate_day ;
/// 604800
FOUNDATION_EXPORT const NSInteger kDate_week ;
/// 31556926
FOUNDATION_EXPORT const NSInteger kDate_year ;

/// yyyy-MM-dd HH:mm:ss
FOUNDATION_EXPORT NSString * const kFormatDate ;
/// yyyy-MM-dd
FOUNDATION_EXPORT NSString * const kFormatDate_one ;
/// yyyyMMdd
FOUNDATION_EXPORT NSString * const kFormatDate_two ;
/// yyyyMMddHHmmss
FOUNDATION_EXPORT NSString * const kFormatDate_five ;
/// EEE, dd MMM yyyy HH:mm:ss GMT
FOUNDATION_EXPORT NSString * const kFormatDate_Six ;

#pragma mark - - File

FOUNDATION_EXPORT const NSInteger kPageSize ;
FOUNDATION_EXPORT const NSInteger kFileSize_image ;

//plist文件路径
FOUNDATION_EXPORT NSString * const kPlistFilePath ;
//plist文件名
FOUNDATION_EXPORT NSString * const kPlistName_common ;

#pragma mark - - kTag

FOUNDATION_EXPORT const NSInteger kTAG_LABEL ;
FOUNDATION_EXPORT const NSInteger kTAG_BTN ;
FOUNDATION_EXPORT const NSInteger kTAG_BTN_RightItem ;
FOUNDATION_EXPORT const NSInteger kTAG_BTN_BackItem ;

FOUNDATION_EXPORT const NSInteger kTAG_IMGVIEW ;
FOUNDATION_EXPORT const NSInteger kTAG_TEXTFIELD ;
FOUNDATION_EXPORT const NSInteger kTAG_TEXTVIEW ;
FOUNDATION_EXPORT const NSInteger kTAG_ALERT_VIEW ;
FOUNDATION_EXPORT const NSInteger kTAG_ACTION_SHEET ;
FOUNDATION_EXPORT const NSInteger kTAG_PICKER_VIEW ;
FOUNDATION_EXPORT const NSInteger kTAG_DATE_PICKER ;

FOUNDATION_EXPORT const NSInteger kTAG_VIEW ;
FOUNDATION_EXPORT const NSInteger kTAG_VIEW_Segment ;
FOUNDATION_EXPORT const NSInteger kTAG_VIEW_RADIO ;
FOUNDATION_EXPORT const NSInteger kTAG_VIEW_Picture ;

FOUNDATION_EXPORT const NSInteger kTAG_UItableViewCell ;

FOUNDATION_EXPORT const NSInteger kTAG_ICAROUSEL ;
FOUNDATION_EXPORT const NSInteger kTAG_PAGE_CONTROL ;

FOUNDATION_EXPORT const NSInteger kComponent_0 ;
FOUNDATION_EXPORT const NSInteger kComponent_1 ;
FOUNDATION_EXPORT const NSInteger kComponent_2 ;


#pragma mark - -MacroGeometry与计算有关的尺寸属性
/// 顶部状态栏 20
FOUNDATION_EXPORT const CGFloat kStatusBarHeight ;
/// 导航栏高 44
FOUNDATION_EXPORT const CGFloat kNaviBarHeight ;
/// 底部tabBar高度 49
FOUNDATION_EXPORT const CGFloat kTabBarHeight ;
/// 选择器默认高度 180
FOUNDATION_EXPORT const CGFloat kPickerViewHeight;

FOUNDATION_EXPORT const CGFloat kH_SegmentOfCustom ;
FOUNDATION_EXPORT const CGFloat kH_SegmentControl;

FOUNDATION_EXPORT const CGFloat kH_searchBar;
FOUNDATION_EXPORT const CGFloat kH_searchBarBackgroud;

FOUNDATION_EXPORT const CGFloat kH_topView;
FOUNDATION_EXPORT const CGFloat kH_slideView;
FOUNDATION_EXPORT const CGFloat kH_CellHeight ;

FOUNDATION_EXPORT const CGFloat kX_GAP ;
FOUNDATION_EXPORT const CGFloat kY_GAP ;
FOUNDATION_EXPORT const CGFloat kPadding ;
FOUNDATION_EXPORT const CGFloat kW_LayerBorder ;
FOUNDATION_EXPORT const CGFloat kWH_ArrowRight ;
FOUNDATION_EXPORT const CGFloat kTimerValue ;
FOUNDATION_EXPORT const CGFloat kRatio_IDCard ;
FOUNDATION_EXPORT const CGFloat kRatio_LeftMenu ;

FOUNDATION_EXPORT const CGFloat kDurationShow;
FOUNDATION_EXPORT const CGFloat kDurationToast ;
FOUNDATION_EXPORT const CGFloat kDurationDrop ;

FOUNDATION_EXPORT const CGFloat kW_item ;
FOUNDATION_EXPORT const CGFloat kW_progressView ;

FOUNDATION_EXPORT const CGFloat kH_LABEL ;
FOUNDATION_EXPORT const CGFloat kH_LABEL_TITLE ;
FOUNDATION_EXPORT const CGFloat kH_LABEL_SMALL ;

FOUNDATION_EXPORT const CGFloat kH_TEXTFIELD ;
FOUNDATION_EXPORT const CGFloat kH_LINE_VIEW ;
FOUNDATION_EXPORT const CGFloat kW_LINE_Vert ;

#pragma mark - -font

FOUNDATION_EXPORT const CGFloat kFontSize18 ;
FOUNDATION_EXPORT const CGFloat kFontSize16 ;
FOUNDATION_EXPORT const CGFloat kFontSize14 ;
FOUNDATION_EXPORT const CGFloat kFontSize12 ;
FOUNDATION_EXPORT const CGFloat kFontSize10 ;

#pragma mark - -视图

FOUNDATION_EXPORT NSString * const kIMG_arrowRight ;
FOUNDATION_EXPORT NSString * const kIMG_arrowDown ;
FOUNDATION_EXPORT NSString * const kIMG_arrowBack ;
FOUNDATION_EXPORT NSString * const kIMG_arrowUp ;

FOUNDATION_EXPORT NSString * const kIMG_portrait ;
FOUNDATION_EXPORT NSString * const kIMG_portrait_N ;
FOUNDATION_EXPORT NSString * const kIMG_portrait_H ;
FOUNDATION_EXPORT NSString * const kIMG_pictureAdd ;
FOUNDATION_EXPORT NSString * const kIMG_pictureDelete ;

FOUNDATION_EXPORT NSString * const kIMG_defaultFailed ;
FOUNDATION_EXPORT NSString * const kIMG_defaultFailed_S ;

FOUNDATION_EXPORT NSString * const kIMG_sexBoy ;
FOUNDATION_EXPORT NSString * const kIMG_sexGril ;

FOUNDATION_EXPORT NSString * const kIMG_elemetDec ;
FOUNDATION_EXPORT NSString * const kIMG_elemetInc ;

FOUNDATION_EXPORT NSString * const kIMG_scan ;
FOUNDATION_EXPORT NSString * const kIMG_NFC ;

FOUNDATION_EXPORT NSString * const kIMG_inquiry ;
FOUNDATION_EXPORT NSString * const kIMG_update ;
FOUNDATION_EXPORT NSString * const kIMG_warning ;

FOUNDATION_EXPORT NSString * const kIMG_notice ;
FOUNDATION_EXPORT NSString * const kIMG_location_H ;
FOUNDATION_EXPORT NSString * const kIMG_more ;

FOUNDATION_EXPORT NSString * const kIMG_selected_NO ;
FOUNDATION_EXPORT NSString * const kIMG_selected_YES ;
FOUNDATION_EXPORT NSString * const kIMG_Add ;

FOUNDATION_EXPORT NSString * const kIMG_like_H ;
FOUNDATION_EXPORT NSString * const kIMG_like_W ;

FOUNDATION_EXPORT NSString * const kNetWorkRequesting ;
FOUNDATION_EXPORT NSString * const kNetWorkFailed ;
FOUNDATION_EXPORT NSString * const kNetWorkNodata ;
FOUNDATION_EXPORT NSString * const kNetWorkNoMoredata ;
FOUNDATION_EXPORT NSString * const kNetWorkFailedParams ;

FOUNDATION_EXPORT NSString * const kLocationing ;
FOUNDATION_EXPORT NSString * const kLocationSuccess ;
FOUNDATION_EXPORT NSString * const kLocationFailed ;
FOUNDATION_EXPORT NSString * const kIDCardFailed ;
FOUNDATION_EXPORT NSString * const kIDCardSuccess ;

/// 重置
FOUNDATION_EXPORT NSString * const kTitleDefault ;
/// 知道了
FOUNDATION_EXPORT NSString * const kTitleKnow ;
/// 确定
FOUNDATION_EXPORT NSString * const kTitleSure ;
/// 取消
FOUNDATION_EXPORT NSString * const kTitleCancell ;
/// 删除
FOUNDATION_EXPORT NSString * const kTitleDelete ;
/// 彻底删除
FOUNDATION_EXPORT NSString * const kTitleDrop ;
/// 呼叫
FOUNDATION_EXPORT NSString * const kTitleCall ;
/// 立即升级
FOUNDATION_EXPORT NSString * const kTitleUpdate ;
/// 收藏
FOUNDATION_EXPORT NSString * const kTitleCollect ;
/// 恢复
FOUNDATION_EXPORT NSString * const kTitleRecover ;
/// --
FOUNDATION_EXPORT NSString * const kNilText ;
/// ,
FOUNDATION_EXPORT NSString * const kSeparateStr ;
/// *
FOUNDATION_EXPORT NSString * const kAsterisk ;
/// 空格(半个字体)
FOUNDATION_EXPORT NSString * const kBlankHalf ;
/// 空格(1个字体)
FOUNDATION_EXPORT NSString * const kBlankOne ;
/// 空格(2个字体)

FOUNDATION_EXPORT NSString * const kBlankTwo ;
/// 空格(4个字体)
FOUNDATION_EXPORT NSString * const kBlankFour ;

#pragma mark - - 通用

FOUNDATION_EXPORT NSString * const kDesWeek ;
FOUNDATION_EXPORT NSString * const kDesMonth ;
FOUNDATION_EXPORT NSString * const kDesDay ;

FOUNDATION_EXPORT NSString * const kItem_obj ;
FOUNDATION_EXPORT NSString * const kItem_objSeleted ;
FOUNDATION_EXPORT NSString * const kItem_block ;

FOUNDATION_EXPORT NSString * const kItem_title ;
FOUNDATION_EXPORT NSString * const kItem_titleColor ;
FOUNDATION_EXPORT NSString * const kItem_textField ;

FOUNDATION_EXPORT NSString * const kItem_titleSub ;
FOUNDATION_EXPORT NSString * const kItem_titleSubColor ;
FOUNDATION_EXPORT NSString * const kItem_titleSection ;

FOUNDATION_EXPORT NSString * const kItem_image ;
FOUNDATION_EXPORT NSString * const kItem_image_H ;

FOUNDATION_EXPORT NSString * const kItem_controller ;
FOUNDATION_EXPORT NSString * const kItem_controllerTitle ;

FOUNDATION_EXPORT NSString * const kItem_height ;
FOUNDATION_EXPORT NSString * const kItem_dataList ;
FOUNDATION_EXPORT NSString * const kItem_finished ;

FOUNDATION_EXPORT NSString * const kItem_header ;
FOUNDATION_EXPORT NSString * const kItem_footer ;
/**
 推送通知
 */
FOUNDATION_EXPORT NSString * const kNoti_title ;
FOUNDATION_EXPORT NSString * const kNoti_subtitle ;
FOUNDATION_EXPORT NSString * const kNoti_body ;
FOUNDATION_EXPORT NSString * const kNoti_badge ;


/**
 通知
 */
FOUNDATION_EXPORT NSString * const kNotiPostNameLogIn ;
FOUNDATION_EXPORT NSString * const kNotiPostNameLogOut ;
FOUNDATION_EXPORT NSString * const kNotiPostNameBackgroudUploadLocation ;

@interface NNGeneralConst : NSObject

@end
