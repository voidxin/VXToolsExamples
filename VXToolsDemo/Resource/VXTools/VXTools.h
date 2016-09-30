//
//  PSBTools.h
//  
//
//  Created by voidxin on 15/1/27.
//  Copyright (c) 2015年 voidxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VXTools : NSObject

//返回当前版本号
+ (CGFloat)systemVersion;

//获取当前屏幕的高度和宽度
+(CGFloat)screenWidth;
+(CGFloat)screenHeight;

//16进制颜色
+(UIColor *)ColorWithHex:(NSString *)stringToConvert;

//传Formate生成格林尼治时间
+(NSString*)DateTimeWithFormateString:(NSString*)str;

//传Formate生成Now时间
+(NSString*)DateTimeWithFormateNowString:(NSString*)str;

//字典或数组转json
+(NSData *)DictOrArrayToJSONData:(id)theData;

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;

+(CGSize)LabelLengthWithLabel:(UILabel*)label;
+(CGSize)LabelHeightWithLabel:(UILabel*)label;

///判断时间的大小(yyyy-MM-dd)(0：相等，1：第一个时间大约第二个时间，-1：第一个时间小于第二个时间)
+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr;

///时间转换(格林尼治时间转北京时间)
+(NSString*)exchangeDateWithBeiJingDateWithDate:(NSString*)date;

///时间转换（北京时间转格林尼治时间）
+(NSString*)exchangeGMTDateWithBeiJingDate:(NSString *)date WithFormate:(NSString*)formate;
//+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//手机型号
+ (NSString *)getCurrentDeviceModel;

///判断是否为空
+ (BOOL)isBlankString:(NSString *)string;

///字符串转时间
+(NSDate*)dateExchangeWithString:(NSString*)dateStr WithFormate:(NSString*)formate;

//判断时间的大小(0：相等，1：第一个时间大约第二个时间，-1：第一个时间小于第二个时间)
+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr WithFormate:(NSString*)formate;

//计算两个时间相差多少天
+(int)howManyDays:(NSString *)earlyDate laterDate:(NSString *)laterDate;

//获取昨天的时间
+(NSString *)yesterDayWithFormateString:(NSString *)str;


//输入检查
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;

//去掉字符串中得空格和换行符
+(NSString *)deleteSpaceAndSeperateWith:(NSString *)str;

/**
 1开头的数字要11位
 不是以1开头和400开头的要6-12位
 */
+(BOOL)returnLegalPhoneNumber:(NSString *)phoneNumber;


//根据月份获取这个月的开始时间和结束时间
+ (NSString *)returnMonthBeginAndEndWith:(NSString *)dateStr;
//根据当前月份获取指定月份
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

#pragma mark - 只能输入英文和数字
+(BOOL)returnTextAndNumberWithInput:(NSString *)str;


#pragma mark - 文字水印
+ (UIImage *)imageWithLogoText:(UIImage *)img text:(NSString *)text1;

#pragma mark - base64编码
+(NSString *)returnBase64EncodeWith:(NSString *)str;

#pragma mark -  根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark -  image旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
#pragma mark -  获取app版本号
+(NSString *)returnAppVersion;
#pragma mark -  图片加文字
+(UIImage *)addText:(UIImage *)img text:(NSString *)text1;
#pragma mark -  检查电话号码
+ (BOOL)validateMobile:(NSString *)mobileNum;
//判断身份证
+(BOOL)returnTrueIdCardNumber:(NSString *)str;

#pragma mark -  根据string的内容计算高度
+(CGSize)sizeWithString:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


@end







