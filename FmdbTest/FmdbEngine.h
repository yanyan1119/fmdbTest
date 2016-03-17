//
//  FmdbEngine.h
//  FmdbTest
//
//  Created by hky on 16/3/17.
//  Copyright © 2016年 hky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FmdbEngine : NSObject

+(instancetype)shareInstance;

- (void)startEngine;

@end
