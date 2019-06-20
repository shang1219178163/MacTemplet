//
//  NSDateFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

/**
 NSDateFormatter *dateFormatter = [NSDateFormatter dateFormat:@"MM/dd/yyyy"];

 */

#import <Foundation/Foundation.h>

/// 1s
FOUNDATION_EXPORT const NSInteger kDate_second ;
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

@interface NSDateFormatter (Helper)

+ (NSDateFormatter *)dateFormat:(NSString *)formatStr;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

+ (NSDate *)dateFromString:(NSString *)dateStr format:(NSString *)format;

+ (NSString *)stringFromInterval:(NSString *)interval format:(NSString *)format;

+ (NSString *)IntervalFromDateStr:(NSString *)dateStr format:(NSString *)format;

+ (NSDate *)dateFromInterval:(NSString *)interval;

+ (NSString *)IntervalFromDate:(NSDate *)date;

bool IsTimeStamp(id obj);

NSString *TimeStampFromObj(id obj);

@end
