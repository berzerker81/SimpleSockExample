//
//  ViewController.m
//  Sock
//
//  Created by jangwoong on 2017. 2. 20..
//  Copyright © 2017년 SELQA_macbookpro. All rights reserved.
//

#import "ViewController.h"


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
}
- (IBAction)ApplySock:(id)sender {
    UInt32 int32 = [self.port.text intValue];
    _sock = nil;
    _sock = [[Sock alloc] initWithSockAddress:self.target.text port:int32];
}


- (IBAction)sendMessage:(id)sender {
    
    [_sock sendMessage:self.Message.text];
}

- (IBAction)close:(id)sender {
    [_sock close];
}
@end
