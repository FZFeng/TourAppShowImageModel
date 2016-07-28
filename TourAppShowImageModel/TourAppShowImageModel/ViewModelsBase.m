//
//  ViewModelsBase.m
//  TourAppShowImageModel
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 fabius's studio. All rights reserved.
//

#import "ViewModelsBase.h"


@implementation ViewModelsBase

//通过tab编号 获取指定数据 数据的格式为json 包括标题 和图片名称列表 当前的数据都存于本地
//当需接入api 接口时 只需处理网络连接获取返回的数据，即可使用
+ (void)getImageWithTagItemString:(NSString *)tagItemString returnBlock:(void (^)(NSArray *imageArray))returnBlock{

    // @"景点",@"美食",@"酒店",@"交通",@"购物",@"娱乐"
    /*
    //读取本地json数据 并返回
    NSData *fileData;
    NSString *sandBoxPathString;
    NSDictionary *imageDataDictionary;
    
    //此处获取本地数据,接通api接口后，可网络连接api 获回数据
    sandBoxPathString=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    sandBoxPathString=[sandBoxPathString stringByAppendingString:[NSString stringWithFormat:@"/%@.dat",tagItemString]];
    fileData = [[NSFileManager defaultManager] contentsAtPath:sandBoxPathString];
    imageDataDictionary=[NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:nil];
    */
    
    NSMutableArray *returnImageDataMutArray=[[NSMutableArray alloc] init];
    
    if ([tagItemString isEqualToString:@"景点"]) {
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"五龙洞国家森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"slide1.jpg",@"slide2.jpg",@"slide3.jpg",@"slide4.jpg",@"slide5.jpg",@"slide6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"灵崖寺门" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"slide1.jpg",@"slide2.jpg",@"slide3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];
        
        
    }else if ([tagItemString isEqualToString:@"美食"]){
        
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"张家界" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg",@"thumb4.jpg",@"thumb5.jpg",@"thumb6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];
    
    }else if ([tagItemString isEqualToString:@"酒店"]){
        
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"张家界" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg",@"thumb4.jpg",@"thumb5.jpg",@"thumb6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];

    
    }else if ([tagItemString isEqualToString:@"交通"]){
        
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"张家界" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg",@"thumb4.jpg",@"thumb5.jpg",@"thumb6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];

    
    }else if ([tagItemString isEqualToString:@"购物"]){
        
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"张家界" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg",@"thumb4.jpg",@"thumb5.jpg",@"thumb6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];

    
    }else if ([tagItemString isEqualToString:@"娱乐"]){
        
        //1
        NSMutableDictionary *imageDataMutDictionary1=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary1 setObject:@"张家界" forKey:@"title"];
        //image
        [imageDataMutDictionary1 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg",@"thumb4.jpg",@"thumb5.jpg",@"thumb6.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary1];
        
        //2
        NSMutableDictionary *imageDataMutDictionary2=[[NSMutableDictionary alloc] init];
        //title
        [imageDataMutDictionary2 setObject:@"森林公园" forKey:@"title"];
        //image
        [imageDataMutDictionary2 setObject:@[@"thumb1.jpg",@"thumb2.jpg",@"thumb3.jpg"] forKey:@"image"];
        
        [returnImageDataMutArray addObject:imageDataMutDictionary2];

    }
    
    returnBlock([returnImageDataMutArray copy]);
    
}

@end
