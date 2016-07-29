//
//  imageMutLineTableViewCell.h
//  TourAppShowImageModel
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 fabius's studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageMutLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *imageListView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mainViewTrailingLayoutConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mainViewLeadingLayoutConstraint;


@end
