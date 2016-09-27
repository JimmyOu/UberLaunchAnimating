//
//  TileGridView.h
//  UberLaunchAnimating_OC
//
//  Created by JimmyOu on 16/9/27.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileGridView : UIView
-(instancetype)initWithTileFileName:(NSString *)name;
- (void)startAnimating;
@end
