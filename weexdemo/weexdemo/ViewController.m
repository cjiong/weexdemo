//
//  ViewController.m
//  weexdemo
//
//  Created by 陈炯 on 2017/3/25.
//  Copyright © 2017年 Jiong. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WXSDKInstance.h>

@interface ViewController ()
@property(nonatomic, strong) WXSDKInstance *instance;
@property(nonatomic, strong) UIView *weexView;
@end

@implementation ViewController {
    NSURL *jsUrl;
}

- (instancetype)initWithJs:(NSString *)filePath {
    self = [super init];
    if (self) {
        NSString *path=[NSString stringWithFormat:@"file://%@/js/%@",[NSBundle mainBundle].bundlePath,filePath];
        jsUrl = [NSURL URLWithString:path];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    __weak typeof(self) weakSelf = self;
    
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"load failed");
    };
    
    _instance.renderFinish = ^(UIView *view) {
        NSLog(@"success");
    };
    
    [_instance renderWithURL:jsUrl];
}

- (void)dealloc {
    [_instance destroyInstance];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
