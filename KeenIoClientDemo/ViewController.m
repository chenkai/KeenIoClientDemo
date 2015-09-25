//
//  ViewController.m
//  KeenIoClientDemo
//
//  Created by chenkai on 15/8/14.
//  Copyright (c) 2015年 chenkai. All rights reserved.
//

#import "ViewController.h"
#import "KeenClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    [[KeenClient sharedClient] addEvent:singleEvent toEventCollection:@"MainView_CT" error:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    KeenClient *client = [KeenClient sharedClient];
    client.globalPropertiesBlock = ^NSDictionary *(NSString *eventCollection) {
        if ([eventCollection isEqualToString:@"MainView_CT"]) {
            return @{ @"OS_Version": @"9.0" };
        } else {
            return nil;
        }
    };
    
    NSDictionary *singleEvent = [NSDictionary dictionaryWithObjectsAndKeys:@"LoginViewController", @"ViewPath",
                                                                           @"Enter",@"Action",
                                                                           nil];
    NSDate *defineDate = [NSDate date];
    KeenProperties *dateProperties = [[KeenProperties alloc] init];
    dateProperties.timestamp = defineDate;//自定义时间戳
    
    [client addEvent:singleEvent
                     withKeenProperties:dateProperties
                      toEventCollection:@"MainView_CT"
                                  error:nil];
    [client uploadWithFinishedBlock:^{
        NSLog(@"upload event finished");
    }];
}

@end
