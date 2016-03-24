//
//  StudentModel.h
//  FmdbTest
//
//  Created by hky on 16/3/17.
//  Copyright © 2016年 hky. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface StudentModel : NSObject
{
    NSString *_ivarOne;
    UITextView *_ivarTwo;
    UITextField *_ivarThree;
    NSNumber *_ivarFour;
}

@property (nonatomic, copy) NSString *myName;
@property (nonatomic, assign) NSInteger myNumber;
@property (nonatomic, retain) NSString *myAge;
@property (nonatomic, weak) NSString *myFirstName;
@property (copy,readonly) NSArray *array;
@property (nonatomic, copy) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, getter=isRight) BOOL right;
@property (nonatomic, setter=setLastname:) NSString *myLastName;
@property (nonatomic, strong) NSMutableDictionary *mutalbeDict;
@property (nonatomic, strong) NSCharacterSet *set;
@property (nonatomic, assign) NSInteger myInteger;
@property (nonatomic, assign) int myInt;
@property (nonatomic, assign) unsigned int myUnsignInt;
@property (nonatomic, assign) float myFloat;
@property (nonatomic, assign) double myDouble;
@property (nonatomic, assign) long myLong;
@property (nonatomic, assign) Point myPoint;
@property (nonatomic, assign) Rect myRect;

@end
