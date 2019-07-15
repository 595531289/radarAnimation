//
//  ViewController.m
//  WBRadarAnimationDemo
//
//  Created by 王斌 on 2019/7/15.
//  Copyright © 2019 wangbin. All rights reserved.
//

#import "ViewController.h"
#import "WBRadarAnimation.h"
#define WINDOW_WIDTH     [UIScreen mainScreen].bounds.size.width
#define WINDOW_HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) WBRadarAnimation *radarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.radarView];
    [self createBtn];

}
- (void)createBtn{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(60, 80, 100, 40);
    [startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(200, 80, 100, 40);
    [stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}
- (void)start{
    [self.radarView startRadarAnimation];
}
- (void)stop{
    [self.radarView stopRadarAnimation];
}
- (WBRadarAnimation *)radarView{
    if (!_radarView) {
        _radarView = [[WBRadarAnimation alloc] initWithFrame:CGRectMake((WINDOW_WIDTH-85)/2,(WINDOW_HEIGHT-85)/2,85,85)];
        _radarView.radarColor = [UIColor colorWithRed:14/255.0 green:134/255.0 blue:254/255.0 alpha:1];
    }
    return _radarView;
}


@end
