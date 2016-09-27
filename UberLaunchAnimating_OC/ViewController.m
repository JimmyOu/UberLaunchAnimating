//
//  ViewController.m
//  UberLaunchAnimating_OC
//
//  Created by JimmyOu on 16/9/27.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedULogoView.h"
#import "Contans.h"
#import "TileGridView.h"
@interface ViewController ()
@property (nonatomic,strong) AnimatedULogoView *animatedView;
@property (nonatomic, strong) TileGridView *tileGridView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //background animating View
    _tileGridView = [[TileGridView alloc] initWithTileFileName:@"Chimes"];
    [self.view addSubview:_tileGridView];
    _tileGridView.frame = [UIScreen mainScreen].bounds;
    
    //logo animating View
    _animatedView = [[AnimatedULogoView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [self.view addSubview:_animatedView];
    _animatedView.layer.position = self.view.layer.position;
    self.view.backgroundColor = UberBlue;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tileGridView startAnimating];
    [_animatedView startAniamting];
}


@end
