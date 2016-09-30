//
//  PSBTools.m
//
//
//  Created by voidxin on 15/1/27.
//  Copyright (c) 2015年 voidxin. All rights reserved.
//

#import "VXTools.h"
#include <sys/types.h>
#import <sys/sysctl.h>

@implementation VXTools

//返回当前版本号
+ (CGFloat)systemVersion
{
    return [UIDevice currentDevice].systemVersion.floatValue;
}
+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
    
}

+ (CGFloat)screenWidth
{
//    return [UIScreen mainScreen].bounds.size.width;
    return [UIScreen mainScreen].bounds.size.width;
}
//十六进制颜色
//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)ColorWithHex:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
//获取8小时前的时间
+ (NSString*)DateTimeWithFormateString:(NSString*)str
{
    NSDate * date=[NSDate date];
    NSDateFormatter * df=[[NSDateFormatter alloc]init];
    df.dateFormat=str;
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"UTC"];
    [df setTimeZone:timeZone];
    NSString * dateString=[df stringFromDate:date];
    return dateString;
}
//获取当前时间
+ (NSString*)DateTimeWithFormateNowString:(NSString *)str
{
    NSDate * date=[NSDate date];
    NSDateFormatter * df=[[NSDateFormatter alloc]init];
    df.dateFormat=str;
    NSString * dateString=[df stringFromDate:date];
    return dateString;
}

+ (NSString *)yesterDayWithFormateString:(NSString *)str{
    NSDate *yesterday=[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDateFormatter * dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:str];
    
    return [dateformatter stringFromDate:yesterday];
}
// 将字典或者数组转化为JSON串
+ (NSData *)DictOrArrayToJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
//字符串转时间
+ (NSDate*)dateExchangeWithString:(NSString*)dateStr WithFormate:(NSString*)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    //    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    //    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:dateStr];
    return dateA;
}
//判断时间的大小
+ (int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];

    if (result == NSOrderedDescending) {
       
        return 1;
    }
    else if (result == NSOrderedAscending){
       
        return -1;
    }
    //两个时间相等
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+ (NSString*)exchangeDateWithBeiJingDateWithDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *dateA = [dateFormatter dateFromString:date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone * timeZ=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [df setTimeZone:timeZ];

    NSString * dateString=[df stringFromDate:dateA];
    return dateString;
}
//+ (int)HowDaysWith
+ (NSString*)exchangeGMTDateWithBeiJingDate:(NSString *)date WithFormate:(NSString*)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *dateA = [dateFormatter dateFromString:date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formate];
    NSTimeZone * timeZ=[NSTimeZone timeZoneWithName:@"UTC"];
    [df setTimeZone:timeZ];
    
    NSString * dateString=[df stringFromDate:dateA];
    return dateString;
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus (A1699/A1687/A1634)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s (A1700/A1688/A1633)";
    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+ (int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr WithFormate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSTimeZone * timeZone=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
   
    if (result == NSOrderedDescending) {
        
        return 1;
    }
    else if (result == NSOrderedAscending){
       
        return -1;
    }
    
    return 0;
}

#pragma mark - 获得两个时间相差多少天
+ (int)howManyDays:(NSString *)earlyDate laterDate:(NSString *)laterDate{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *earl=[dateFormater dateFromString:earlyDate];
    NSDate *later=[dateFormater dateFromString:laterDate];
    int second = [later timeIntervalSince1970]-[earl timeIntervalSince1970];
    
    int minute=second/60;
    int hour=minute/60;
    int day=hour/24;
    
    return day;
}





#pragma mark - 输入检查
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

//去掉字符串中的空格和换行符
+ (NSString *)deleteSpaceAndSeperateWith:(NSString *)str{
  
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
   
    return str;
}

//输入的是数字
-(BOOL)PhoneisPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**
   1开头的数字要11位
   不是以1开头和400开头的要6-12位
   00853或00852开头的钥匙十三位
 */
+ (BOOL)returnLegalPhoneNumber:(NSString *)phoneNumber{
    //判断是否是纯数字
    NSScanner* scan = [NSScanner scannerWithString:phoneNumber];
    float val;
    BOOL isTure=[scan scanFloat:&val] && [scan isAtEnd];
    if (phoneNumber.length<5) {
        return NO;
    }
    if (isTure) {
        NSRange range=NSMakeRange(0, 3);
        NSRange HKRange=NSMakeRange(0, 5);
        if (phoneNumber.length!=13 && ![[phoneNumber substringWithRange:HKRange] isEqualToString:@"00853"] && ![[phoneNumber substringWithRange:HKRange] isEqualToString:@"00852"]) {
            if ([[phoneNumber substringToIndex:1] isEqualToString:@"1"]) {
                if (phoneNumber.length==11) {
                    return YES;
                }
            }
            if(![[phoneNumber substringWithRange:range] isEqualToString:@"400"] && ![[phoneNumber substringToIndex:1] isEqualToString:@"1"]){
                //不是以400开头
                if (phoneNumber.length>=6 &&  phoneNumber.length<=12) {
                    return YES;
                }
            }
        }else{
            if (([[phoneNumber substringWithRange:HKRange] isEqualToString:@"00853"] || [[phoneNumber substringWithRange:HKRange] isEqualToString:@"00852"]) && phoneNumber.length==13) {
                return YES;
                
            }
        }
    }
    return NO;
}


//根据月份获取这个月的开始时间和结束时间
+ (NSString *)returnMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@.%@",beginString,endString];
    return s;
}

//根据当前月份获取指定月份
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}




#pragma  mark - 只能输入英文和数字
+ (BOOL)returnTextAndNumberWithInput:(NSString *)str{
    NSString *regex=@"^[A-Za-z0-9]+$";
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
/**
 *  照片加水印
 */
#pragma  mark - 文字水印
+ (UIImage *)imageWithLogoText:(UIImage *)img text:(NSString *)text1
{
    /////注：此为后来更改，用于显示中文。zyq,2013-5-8
    CGSize size = CGSizeMake(200, img.size.height);          //设置上下文（画布）大小
    UIGraphicsBeginImageContext(size);                       //创建一个基于位图的上下文(context)，并将其设置为当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取当前上下文
    CGContextTranslateCTM(contextRef, 0, img.size.height);   //画布的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0);                //画布翻转
    CGContextDrawImage(contextRef, CGRectMake(0, 0, img.size.width, img.size.height), [img CGImage]);  //在上下文种画当前图片
    
    [[UIColor redColor] set];                                //上下文种的文字属性
    CGContextTranslateCTM(contextRef, 0, img.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    UIFont *font = [UIFont boldSystemFontOfSize:25];
    [text1 drawInRect:CGRectMake(10, 100, 200, 150) withFont:font];       //此处设置文字显示的位置
    UIImage *targetimg =UIGraphicsGetImageFromCurrentImageContext();  //从当前上下文种获取图片
    UIGraphicsEndImageContext();                            //移除栈顶的基于当前位图的图形上下文。
    return targetimg;
}


#pragma  mark - base64解码
+ (NSString *)returnBase64EncodeWith:(NSString *)str{
    NSData *nsdata = [str  dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    return base64Encoded;
}

#pragma  mark - 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}
#pragma  mark - image旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
#pragma  mark - 获取app版本号
+ (NSString *)returnAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

#pragma  mark -  图片加文字
+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    /////注：此为后来更改，用于显示中文。zyq,2013-5-8
    CGSize size = CGSizeMake(img.size.width, img.size.height);          //设置上下文（画布）大小
    UIGraphicsBeginImageContext(size);                       //创建一个基于位图的上下文(context)，并将其设置为当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取当前上下文
    CGContextTranslateCTM(contextRef, 0, img.size.height);   //画布的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0);                //画布翻转
    CGContextDrawImage(contextRef, CGRectMake(0, 0, img.size.width, img.size.height), [img CGImage]);  //在上下文种画当前图片
    
    [[UIColor redColor] set];                                //上下文种的文字属性
    CGContextTranslateCTM(contextRef, 0, img.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    UIFont *font = [UIFont boldSystemFontOfSize:30];
    [text1 drawInRect:CGRectMake(img.size.width-180,img.size.height-100, 180, 100) withFont:font];       //此处设置文字显示的位置
    UIImage *targetimg =UIGraphicsGetImageFromCurrentImageContext();  //从当前上下文种获取图片
    UIGraphicsEndImageContext();                            //移除栈顶的基于当前位图的图形上下文。
    return targetimg;
   
}
#pragma  mark - 检查电话号码
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断身份证
+ (BOOL)returnTrueIdCardNumber:(NSString *)str{
    
    NSString *regex = @"\\d{15}(\\d\\d[0-9xX])?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


#pragma  mark - 计算文本的宽高
+ (CGSize)sizeWithString:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attr=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end




