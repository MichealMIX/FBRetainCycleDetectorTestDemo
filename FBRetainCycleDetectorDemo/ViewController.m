//
//  ViewController.m
//  FBRetainCycleDetectorDemo
//
//  Created by 郑锐 on 2019/10/16.
//  Copyright © 2019 郑锐. All rights reserved.
//

#import "ViewController.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
@interface ViewController (){
    void (^_handlerBlock)(void);
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self blockRetainCycle];
    [self timerRetainCycle];
    [self testRetainCycle];
}

- (void)blockRetainCycle {
    _handlerBlock = ^{
        NSLog(@"%@", self);
    };
}

- (void)timerRetainCycle {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(handleTimer)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)handleTimer{
    NSLog(@"timer");
}

- (void)testRetainCycle {

    
    FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] init];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"%@", retainCycles);
}

- (void)dealloc{
    [_timer invalidate];
}

@end
