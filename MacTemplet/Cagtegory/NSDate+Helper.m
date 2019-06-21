//
//  NSDate+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDate+Helper.h"

#import "BNGeneralConst.h"
#import "NSDateFormatter+Helper.h"

#define kDateComponents (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday)

@implementation NSDate(Helper)

static NSCalendar * _calendar = nil;

static NSArray * _dayList = nil;
static NSArray * _monthList = nil;
static NSArray * _weekList = nil;

+ (NSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:NSLocaleIdentifier];
    }
    return _calendar;
}

+ (NSArray *)dayList{
    if (!_dayList) {
        _dayList = [kDes_day componentsSeparatedByString:@","];
    }
    return _dayList;
}

+ (NSArray *)monthList{
    if (!_monthList) {
        _monthList = [kDes_month componentsSeparatedByString:@","];
    }
    return _monthList;
}

+ (NSArray *)weekList{
    if (!_weekList) {
        _weekList = [kDes_week componentsSeparatedByString:@","];
    }
    return _weekList;
}

- (NSString *)timeByAddingDays:(id)days{
    NSParameterAssert([days isKindOfClass:[NSString class]] || [days isKindOfClass:[NSNumber class]]);
    if (!days) days = @0;
    NSString *  newdate = [NSDateFormatter stringFromDate:[self dateByAddDays:[days integerValue]] format:kFormatDate];
    return newdate;
}
/**
 *  获取时间的时间戳
 */
-(NSString *)timeStamp{
   return TimeStampFromObj(self);
}

/**
 *  获取当前时间
 */
-(NSString *)now{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormatDate];
    NSString * dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSDate *)localFromUTC{
    NSDate *soureDate = self;
    //设置源日期时区
    NSTimeZone * sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone * destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:soureDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:soureDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate * destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:soureDate];
    return destinationDate;
}

/*距离当前的时间间隔描述*/

- (NSString *)timeIntervalDescription{
    NSTimeInterval timeInterval = -self.timeIntervalSinceNow;
    if(timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text4",@""), timeInterval /86400];
        
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text5",@"")];
        return [dateFormatter stringFromDate:  self ];
        
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6",@""), timeInterval /31536000];
    }
}

/*精确到分钟的日期描述*/

- (NSString *)minuteDescription{
    NSDateFormatter  *dateFormatter = [NSDateFormatter  dateFormat:kFormatDate];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    if([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat :@"ah:mm"];
        return [dateFormatter stringFromDate:self ];
        
    }
    else if ([[dateFormatter  dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] ==86400) {//昨天
        [dateFormatter setDateFormat :@"ah:mm"];
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:  self ]];
        
    }
    else if ([[dateFormatter dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] <86400*7) {//间隔一周内
        [dateFormatter  setDateFormat :@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self ];
        
    }
    else{//以前
        [dateFormatter setDateFormat :@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:  self ];
        
    }
    
}

/*标准时间日期描述*/

-(NSString *)formattedTime{
    NSDateFormatter  * formatter = [NSDateFormatter dateFormat:@"YYYY-MM-dd"];
    
    NSString* dateNow = [formatter stringFromDate:NSDate.date];
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)]intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)]intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)]intValue]];
    
    NSCalendar *calendar = NSDate.calendar;
    NSDate *date = [calendar dateFromComponents:components];//今天0点时间
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter =nil;
    NSString *ret =@"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j"options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location!=NSNotFound;
    
    if(!hasAMPM) {//24小时制
        if(hour <=24&& hour >=0) {
            dateFormatter = [NSDateFormatter dateFormat:@"HH:mm"];
            
        } else if (hour <0&& hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text8",@"")];
            
        } else {
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
        
    } else {
        
        if(hour >=0&& hour <=6) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text9",@"")];
            
        } else if (hour >6&& hour <=11) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text10",@"")];
            
        } else if (hour >11&& hour <=17) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text11",@"")];
            
        } else if (hour >17&& hour <=24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text12",@"")];
            
        } else if (hour <0&& hour >= -24){
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text13",@"")];
            
        } else {
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
    }
    
    ret = [dateFormatter stringFromDate:  self ];
    return ret;
    
}

/*格式化日期描述*/

- (NSString *)formattedDateDescription{
    NSDateFormatter  *dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger  timeInterval = -[self timeIntervalSinceNow];
    
    if(timeInterval <60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    } else if (timeInterval <3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    } else if (timeInterval <21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    } else if ([theDay isEqualToString:currentDay]) {//当天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14",@""), [dateFormatter stringFromDate:self ]];
        
    } else if ([[dateFormatter dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text7",@""), [dateFormatter stringFromDate:self]];
        
    } else {//以前
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dateFormatter stringFromDate:self];
        
    }
}

- (double)timeIntervalSince1970InMilliSecond {
    double ret = [self  timeIntervalSince1970] *1000;
    return ret;
    
}

+ (NSDate*)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    if(timeIntervalInMilliSecond >140000000000) {
        timeInterval = timeIntervalInMilliSecond /1000;
        
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time]formattedTime];
}

#pragma mark Relative Dates
/**  比较两个日期,年月日, 时分秒 各相差多久
 *   先判断年 若year>0   则相差这么多年,后面忽略
 *   再判断月 若month>0  则相差这么多月,后面忽略
 *   再判断日 若day>0    则相差这么多天,后面忽略(0是今天,1是昨天,2是前天)
 *          若day=0    则是今天 返回相差的总时长
 */
+ (NSDateComponents *)compareCalendar:(NSDate *)date{
    NSDate * currtentDate = [NSDate date];
    // 比较日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 这个返回的是相差多久
    // 比如差12个小时, 无论在不在同一天 day都是0
    // NSDateComponents *components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
    NSDateComponents *currentCalendar =[calendar components:unit fromDate:currtentDate];
    NSDateComponents *targetCalendar =[calendar components:unit fromDate:date];
    
    BOOL isYear = currentCalendar.year == targetCalendar.year;
    BOOL isMonth = currentCalendar.month == targetCalendar.month;
    BOOL isDay = currentCalendar.day == targetCalendar.day;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (isYear) {
        if (isMonth) {
            if (isDay) {
                // 时分秒
                components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
            }
            [components setValue:(currentCalendar.day - targetCalendar.day) forComponent:NSCalendarUnitDay];
        }
        [components setValue:(currentCalendar.month - targetCalendar.month) forComponent:NSCalendarUnitMonth];
    }
    [components setValue:(currentCalendar.year - targetCalendar.year) forComponent:NSCalendarUnitYear];
    return components;
}

/**  最近的日期*/
+ (NSString *)relativeDate:(NSDate *)date{
    
    // 日期格式化类
    NSDateFormatter *format = [NSDateFormatter dateFormat:kFormatDate];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate * currtentDate = [NSDate date];
    NSDateComponents *components = [self compareCalendar:date];
    // 比较时间
    NSTimeInterval t = [currtentDate timeIntervalSinceDate:date];
    
    // 一分钟内
    if (t < 60) {
        return @"刚刚";
    }
    // 一小时内
    else if (t < 60 * 60) {
        return [NSString stringWithFormat:@"%@分钟前", @(t/60)];
    }
    // 今天
    else if (components.year == 0 && components.month == 0 && components.day == 0) {
        if (t/3600 > 3) {
            format.dateFormat = @"HH:mm";
            return [format stringFromDate:date];
        }
        return [NSString stringWithFormat:@"%@小时前", @(t/3600)];
    }
    // 昨天
    else if (components.year == 0 && components.month == 0 && components.day == 1) {
        format.dateFormat = @"昨天 HH:mm";
        return [format stringFromDate:date];
    }
    // 前天
    else if (components.year == 0 && components.month == 0 && components.day == 2) {
        return @"前天";
    }
    // 今年
    else if (components.year == 0) {
        format.dateFormat = @"MM-dd";
        return [format stringFromDate:date];
    }
    // 今年以前
    return [format stringFromDate:date];;
}

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter * dateFormtter = [NSDateFormatter dateFormat:kFormatDate];
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late =[date timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString = @"";
    NSTimeInterval cha = now - late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else{
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1){
        //86400 = 60(分)*60(秒)*24(小时)   3天内
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else{
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:date];
    }
    return timeString;
}

+ (NSString *)compareCurrentTime:(NSDate *)date{
    NSDate * compareDate = date;
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%@月前",@(temp)];
        
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%@年前",@(temp)];
        
    }
    return  result;
    
}

+ (NSString *)compareCurrentTimeDays:(NSDate *)date{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = date;
    
    //     NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:oldDate];
    //     DDLog(@"time:%f",time/60/60/24);
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else{
        temp = temp/24;
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    return  result;
    
}

+ (NSDate *)dateWithDaysFromNow: (NSInteger )days{
    return [NSDate.date dateByAddDays:days];
}

+ (NSDate *)dateTomorrow{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday{
    return [NSDate dateWithDaysFromNow: -1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger )dHours{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSince1970 +kDate_hour* dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger )dMinutes{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSince1970 +kDate_minute* dMinutes;
    NSDate*newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark -Comparing Dates

/**
 返回及其详细的NSDateComponents
 */
+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)aDate{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                                    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |
                                    NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
    NSDateComponents *components = [NSDate.calendar components:calendarUnit fromDate:aDate];
    return components;
}

/**
 两个时间差的NSDateComponents
 */
+ (NSDateComponents *)dateFrom:(NSDate *)aDate to:(NSDate *)anotherDate{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                                    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |
                                    NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
    NSDateComponents *components = [NSDate.calendar components:calendarUnit fromDate:aDate toDate:anotherDate options:0];
    return components;
}

/**
 包含2个日期的年/月/日/时/分/秒数量
 */
+ (NSInteger)numDateFrom:(NSDate *)aDate to:(NSDate *)anotherDate type:(NSNumber *)type{
    NSDateComponents *comp1 = [NSDate dateComponentsFromDate: aDate];
    NSDateComponents *comp2 = [NSDate dateComponentsFromDate: anotherDate];
    NSInteger number = comp2.year - comp1.year + 1;
    switch (type.integerValue) {
        case 1://月
        {
            number = comp2.month - comp1.month + 1;
        }
            break;
        case 2://日
        {
            number = comp2.day - comp1.day + 1;
        }
            break;
        case 3://时
        {
            number = comp2.hour - comp1.hour + 1;

        }
            break;
        case 4://分
        {
            number = comp2.minute - comp1.minute + 1;
        }
            break;
        case 5://秒
        {
            number = comp2.second - comp1.second + 1;
        }
            break;
        default://年
            break;
    }
    return number;
}

/**
 某个日期月份包含的天数
 */
+ (NSInteger)countOfDaysInMonth:(NSDate *)date{
    NSRange range = [NSDate.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/**
 某个日期鱼粉的第一天的值(默认顺序为“日一二三四五六”，1:星期日，2:星期一，依次类推)
 */
+ (NSInteger)firstWeekDay:(NSDate *)date{
    NSInteger day = [NSDate.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:date];
    return day;
}

/**
 根据type值返回0 年月日;1 年; 2 月; 3 周;4 (不同年)月; 5 (不同年)周的对比结果
 */
- (BOOL)isCompareDate:(NSDate *)aDate type:(NSNumber *)type{
    NSDateComponents *comp1 = [NSDate dateComponentsFromDate: self];
    NSDateComponents *comp2 = [NSDate dateComponentsFromDate: aDate];
    
    BOOL result = ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day));
    switch (type.integerValue) {
        case 1://年
            result = (comp1.year == comp2.year);
            
            break;
        case 2://月
            result = ((comp1.year == comp2.year) && (comp1.month == comp2.month));

            break;
        case 3://周
            result = ((comp1.year == comp2.year) && (comp1.weekOfYear == comp2.weekOfYear));

            break;
        case 4://(不同年)月
            result = (comp1.month == comp2.month);
            
            break;
        case 5://(不同年)周
            result = (comp1.weekOfYear == comp2.weekOfYear);
            
            break;
        default://年月日
            break;
    }
    return result;
}


- (BOOL)isToday{
    return [self isCompareDate:NSDate.date type:@0];
}

- (BOOL)isTomorrow{
    return [self isCompareDate:[NSDate dateWithDaysFromNow:1] type:@0];
}

- (BOOL)isYesterday{
    return [self isCompareDate:[NSDate dateWithDaysFromNow:-1] type:@0];
}

- (BOOL)isSameWeekAsDate:(NSDate *) aDate{
    return [self isCompareDate:aDate type:@3];
}
       
- (BOOL)isThisWeek{
    return [self isSameWeekAsDate:NSDate.date];
}

- (BOOL)isNextWeek{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSince1970 +kDate_week;
    NSDate*newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSince1970 -kDate_week;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)isSameMonthAsDate:(NSDate *)aDate{
    return [self isCompareDate:aDate type:@2];
}

- (BOOL)isThisMonth{
    return [self isSameMonthAsDate:NSDate.date];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate{
    return [self isCompareDate:aDate type:@1];
}

- (BOOL)isThisYear{
    return [self isSameYearAsDate:NSDate.date];
}

- (BOOL)isNextYear{
    NSDateComponents *comp1 = [NSDate dateComponentsFromDate: self];
    NSDateComponents *comp2 = [NSDate dateComponentsFromDate: NSDate.date];
    return (comp1.year == (comp2.year+1));
}

- (BOOL)isLastYear{
    NSDateComponents *comp1 = [NSDate dateComponentsFromDate: self];
    NSDateComponents *comp2 = [NSDate dateComponentsFromDate: NSDate.date];
    return (comp1.year == (comp2.year-1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate{
    return ([self compare:aDate] ==NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate{
    return ([self compare:aDate] ==NSOrderedDescending);
}

- (BOOL)isInFuture{
    return ([self isLaterThanDate:NSDate.date]);
}

- (BOOL)isInPast{
    return ([self isEarlierThanDate:NSDate.date]);
}

#pragma mark Roles

- (BOOL)isTypicallyWeekend{
    NSDateComponents *comp1 = [NSDate dateComponentsFromDate: self];
    if((comp1.weekday == 1) || (comp1.weekday == 7)) return YES;
    return NO;
}

- (BOOL)isTypicallyWorkday{
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)dateByAddingDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSTimeInterval aTimeInterval = self.timeIntervalSince1970 + kDate_day*day + kDate_hour*hour + kDate_minute*minute + kDate_second*second;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddDays:(NSInteger) dDays{
    return [self dateByAddingDay:dDays hour:0 minute:0 second:0];;
}

- (NSDate *)dateByAddHours:(NSInteger )dHours{
    return [self dateByAddingDay:0 hour:dHours minute:0 second:0];;
}

- (NSDate *)dateByAddMinutes:(NSInteger )dMinutes{
    return [self dateByAddingDay:0 hour:0 minute:dMinutes second:0];;
}

/**
 多少小时,分钟,秒之后的NSDate
 */
- (NSDate *)dateAfterHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
//    NSDateComponents *comp = [NSDate.calendar components:NSUIntegerMax fromDate:self];
    NSDateComponents *comp = [NSDate dateComponentsFromDate:self];
    comp.hour   = hour;
    comp.minute = minute;
    comp.second = second;
    return [NSDate.calendar dateFromComponents:comp];
}

- (NSDate *)dateAtStartOfDay{
    return [self dateAfterHour:0 minute:0 second:0];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate{
    NSDateComponents  *dTime = [NSDate.calendar components:kDateComponents fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger ) (ti /kDate_minute);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger)(ti /kDate_minute);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti /kDate_hour);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /kDate_hour);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti /kDate_day);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /kDate_day);
}

- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate{
    NSCalendar *calendar = NSDate.calendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark -- Decomposing Dates

- (NSInteger)nearestHour{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSince1970 + kDate_minute*30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [NSDate dateComponentsFromDate:newDate];
    return components.hour;
}

- (NSDateComponents *)components{
    NSDateComponents *components = [NSDate dateComponentsFromDate:self];
    return components;
}

- (NSInteger)hour{
    return self.components.hour;
}

- (NSInteger)minute{
    return self.components.minute;
}

- (NSInteger)seconds{
    return self.components.second;
}

- (NSInteger)day{
    return self.components.day;
}

- (NSInteger)month{
    return self.components.month;
}

- (NSInteger)week{
    return self.components.weekOfMonth;
}

- (NSInteger)weekday{
    return self.components.weekday;
}

- (NSInteger)weekdayOrdinal{// e.g. 2nd Tuesday of the month is 2
    return self.components.weekdayOrdinal;
}

- (NSString *)weekdayDes{
    return NSDate.weekList[self.weekdayOrdinal - 1];
}

- (NSInteger)year{
    return self.components.year;
}


           
@end
