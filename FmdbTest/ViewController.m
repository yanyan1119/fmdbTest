//
//  ViewController.m
//  FmdbTest
//
//  Created by hky on 16/3/17.
//  Copyright © 2016年 hky. All rights reserved.
//

#import "ViewController.h"
#import "FmdbEngine.h"
#import <objc/runtime.h>
#import "StudentModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [[FmdbEngine shareInstance] startEngine];
    
    
    NSString *string = @"MYChoiceAddressVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>";
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *className;
    NSString *superClassName;
    NSString *protocolNames;
    [scanner scanUpToString:@":" intoString:&className];
    if (!scanner.isAtEnd) {
        scanner.scanLocation = scanner.scanLocation + 1;
        [scanner scanUpToString:@"<" intoString:&superClassName];
        if (!scanner.isAtEnd) {
            scanner.scanLocation = scanner.scanLocation + 1;
            [scanner scanUpToString:@">" intoString:&protocolNames];
        }
    }
    
    unsigned int outCount ;
    objc_property_t *propertyList = class_copyPropertyList([StudentModel class], &outCount);//获取类属性列表
    for (unsigned int i = 0;i < outCount;i ++ )
    {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);//获取属性的名字
        const char *propertyDesc = property_getAttributes(property);//获取属性整体描述
        const char *propertyValue = property_copyAttributeValue(property, propertyName);//获取属性的值
        NSLog(@"\n\n%s 属性的描述是:%s ==== 值是：%s",propertyName,propertyDesc,propertyValue);
        
        unsigned int attCount;
        objc_property_attribute_t *attList = property_copyAttributeList(property, &attCount);//获取属性的描述列表，结果是一个类型为objc_property_attribute_t结构体组成的数组
        for (unsigned int j = 0; j < attCount; j ++) {
            objc_property_attribute_t att = attList[j];
            const char * name = att.name;
            const char * value = att.value;
            NSLog(@"%s 属性的名字是 %s 值是:%s",propertyName,name,value);
        }
    }
    
    //1、name为T 表示属性的类型 类型为基本对象类型和基本数据类型，基本对象类型的value为该对象类型名字 如NSArray、NSString、NSMutableDictionary 等； 基本类型中： Bool为B、 NSInteger 为q、int为i、unsigned int为I、float为f、double为d、long也是q、Point为{Point=ss}、Rect为{Rect=ssss} 等等
    //2、name 为C 表示该属性为copy ；为&表示属性为strong；W表示属性为weak；空 表示属性为assgin ；以上value均为无值
    //3、原子属性 空表示原子属性；name 为N表示为非原子属性 ，表示原子和非原子属性的时候value为无值
    //4、name为V表示属性的名字 此时value为加了下划线的属性名字
    //5、name为R 表示只读属性readonly,此时value无值
    //6、name 为G表示设置getter方法 此时value为用户设定的getter方法名；name为S表示用户设置了setter方法，此时value为用户设置的setter方法
    
    
    unsigned int ivarCount;
    //获取类成员变量列表，包括类的属性property
    Ivar *ivarList = class_copyIvarList([StudentModel class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i ++) {
        //获取指定成员变量的名字
        const char *ivarName = ivar_getName(ivarList[i]);
        //获取成员变量的类型 类型参考property_copyAttributeList中name为T的值
        const char *ivarTypeEncoding = ivar_getTypeEncoding(ivarList[i]);
        //获取成员变量在类对象中的内存偏移值
        ptrdiff_t ivarOffset = ivar_getOffset(ivarList[i]);
        NSLog(@"ivarList[i]成员变量的名字是：%s，类型是：%s，偏移是：%td",ivarName,ivarTypeEncoding,ivarOffset);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
