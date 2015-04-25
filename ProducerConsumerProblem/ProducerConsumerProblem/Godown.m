//
//  Godown.m
//  ProducerConsumerModel
//
//  Created by lijunjie on 15/4/23.
//  Copyright (c) 2015年 lijunjie. All rights reserved.
//

#import "Godown.h"

@interface Godown ()
{
    NSMutableArray *products;
    NSCondition *condition;
}

@end

@implementation Godown

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"begin condition works!");
        products = [[NSMutableArray alloc] init];
        condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)createConsumenr
{
    [condition lock];
    while ([products count] == 0) {
        NSLog(@"wait for products");
        [condition wait];
    }
    NSArray *arr = [NSArray arrayWithArray:products];
    [products removeObjectsInArray:arr];
    NSLog(@"comsume a product");
    [condition unlock];
    //处理产品
    sleep(5);
}

- (void)createProducter
{
    [condition lock];
    [products addObject:[[NSObject alloc] init]];
    NSLog(@"produce a product");
    [condition signal];
    [condition unlock];
}

@end
