//
//  Friend.h
//  SearchAppDemo
//
//  Created by Xudongdong on 16/6/6.
//  Copyright © 2016年 ThirtyOneDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Friend : NSObject

@property (copy, nonatomic) NSString * f_id;
@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * webUrl;

@end
