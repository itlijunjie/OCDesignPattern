//
//  ViewController.m
//  ProducerConsumerModel
//
//  Created by lijunjie on 15/4/23.
//  Copyright (c) 2015年 lijunjie. All rights reserved.
//

#import "ViewController.h"
#import "Godown.h"

@interface ViewController ()
{
    Godown *_godown;
    NSThread *_producterThread;
    NSThread *_consumenrThread;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _godown = [[Godown alloc] init];
    _producterThread = [[NSThread alloc] initWithTarget:self selector:@selector(producterThreadEntryPoint:) object:nil];
    [_producterThread setThreadPriority:1.0];
    [_producterThread start];
    _consumenrThread = [[NSThread alloc] initWithTarget:self selector:@selector(consumenrThreadEntryPoint:) object:nil];
    [_consumenrThread setThreadPriority:1.0];
    [_consumenrThread start];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)producterThreadEntryPoint:(id __unused)object
{
    do {
        @autoreleasepool {
            [[NSThread currentThread] setName:@"producterThread"];
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

- (void)consumenrThreadEntryPoint:(id __unused)object
{
    do {
        @autoreleasepool {
            [[NSThread currentThread] setName:@"consumenrThread"];
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)producterAction:(id)sender
{
    [_godown performSelector:@selector(createProducter) onThread:_producterThread withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];

}

- (IBAction)consumenrAction:(id)sender
{
    [_godown performSelector:@selector(createConsumenr) onThread:_consumenrThread withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}


@end
