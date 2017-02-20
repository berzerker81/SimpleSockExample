//
//  ViewController.h
//  Sock
//
//  Created by jangwoong on 2017. 2. 20..
//  Copyright © 2017년 SELQA_macbookpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sock.h"
@interface ViewController : UIViewController
{
    @private
    
    Sock * _sock;
    
}
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UITextField *target;
@property (weak, nonatomic) IBOutlet UITextField *Message;
@property (weak, nonatomic) IBOutlet UITextView *receive;

- (IBAction)sendMessage:(id)sender;
- (IBAction)close:(id)sender;

@end

