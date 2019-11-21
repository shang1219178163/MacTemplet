//
//  NSDate+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Helper)

@property (class, nonatomic, readonly) NSCalendar *calendar;
@property (class, nonatomic, readonly) NSArray *monthList;
@property (class, nonatomic, readonly) NSArray *dayList;
@property (class, nonatomic, readonly) NSArray *weekList;

@property (nonatomic, strong, readonly) NSString *timeStamp;
@property (nonatomic, strong, readonly) NSString *now;

- (NSString *)timeByAddingDays:(id)days;

- (NSDate *)localFromUTC;

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述

- (NSString *)minuteDescription;/*精确到分钟的日期描述*/

- (NSString *)formattedTime;

- (NSString *)formattedDateDescription;//格式化日期描述

- (double)timeIntervalSince1970InMilliSecond;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

+ (NSString *)formattedTimeFromTimeInterval:(long long)time;

// Relative dates from the current date
+ (NSDateComponents *)compareCalendar:(NSDate *)date;

+ (NSString *)relativeDate:(NSDate *)date;

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp;

+ (NSString *)compareCurrentTime:(NSDate *)date;

+ (NSString *)compareCurrentTimeDays:(NSDate *)date;

+ (NSDate *)dateTomorrow;

+ (NSDate *)dateYesterday;

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;


// Comparing dates
+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)aDate;

+ (NSDateComponents *)dateFrom:(NSDate *)aDate to:(NSDate *)anotherDate;

+ (NSInteger)numDateFrom:(NSDate *)aDate to:(NSDate *)anotherDate type:(NSNumber *)type;

+ (NSInteger)countOfDaysInMonth:(NSDate *)date;
    
- (BOOL)isCompareDate:(NSDate *)aDate type:(NSNumber *)type;
    
- (BOOL)isToday;

- (BOOL)isTomorrow;

- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;

- (BOOL)isThisWeek;

- (BOOL)isNextWeek;

- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;

- (BOOL)isThisMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;

- (BOOL)isThisYear;

- (BOOL)isNextYear;

- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;

- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (BOOL)isInFuture;

- (BOOL)isInPast;

// Date roles

- (BOOL)isTypicallyWorkday;

- (BOOL)isTypicallyWeekend;

// Adjusting dates

- (NSDate *)dateByAddDays:(NSInteger ) dDays;

- (NSDate *)dateByAddHours:(NSInteger ) dHours;

- (NSDate *)dateByAddMinutes:(NSInteger ) dMinutes;

- (NSDate *)dateAtStartOfDay;

- (NSDate *)dateAfterHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

// Retrieving intervals

- (NSInteger)minutesAfterDate:(NSDate *)aDate;

- (NSInteger)minutesBeforeDate:(NSDate *)aDate;

- (NSInteger)hoursAfterDate:(NSDate *)aDate;

- (NSInteger)hoursBeforeDate:(NSDate *)aDate;

- (NSInteger)daysAfterDate:(NSDate *)aDate;

- (NSInteger)daysBeforeDate:(NSDate *)aDate;

- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate;

// Decomposing dates

@property (nonatomic, readonly) NSInteger nearestHour;

@property (nonatomic, readonly) NSInteger hour;

@property (nonatomic, readonly) NSInteger minute;

@property (nonatomic, readonly) NSInteger seconds;

@property (nonatomic, readonly) NSInteger day;

@property (nonatomic, readonly) NSInteger month;

@property (nonatomic, readonly) NSInteger week;

@property (nonatomic, readonly) NSInteger weekday;

@property (nonatomic, readonly) NSInteger weekdayOrdinal;// e.g. 2nd Tuesday of the month == 2

@property (nonatomic, readonly) NSString *weekdayDes;

@property (nonatomic, readonly) NSInteger year;

@property (nonatomic, readonly) NSDateComponents *components;

@end
