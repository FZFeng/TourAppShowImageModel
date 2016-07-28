//
//  ViewModelsBase.h
//  TourAppShowImageModel
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 fabius's studio. All rights reserved.
//  Info:所有业务类的基类，其它类，都继承此类 此类定义公共方法，公共变量

#import <Foundation/Foundation.h>


@interface ViewModelsBase : NSObject

//通过tab编号 获取指定数据 数据的格式为json 包括标题 和图片名称列表 当前的数据都存于本地
//当需接入api 接口时 只需处理网络连接获取返回的数据，即可使用
+ (void)getImageWithTagItemString:(NSString *)tagItemString returnBlock:(void (^)(NSArray *imageArray))returnBlock;

@end
