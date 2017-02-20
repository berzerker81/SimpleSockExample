//
//  Sock.h
//  Sock
//
//  Created by jangwoong on 2017. 2. 20..
//  Copyright © 2017년 SELQA_macbookpro. All rights reserved.
//  https://www.raywenderlich.com/3932/networking-tutorial-for-ios-how-to-create-a-socket-based-iphone-app-and-server

#import <Foundation/Foundation.h>

@interface Sock : NSObject<NSStreamDelegate>
{
    @private
    NSInputStream *  _inputStream;
    NSOutputStream * _outputStream;
    bool             _serverOpen;
    bool             _reconnection;
    //NSString *       _IPPort;
    int              _serverTimeOut;
    
}
-(id)initWithSockAddress:(NSString*)target port:(UInt32)port;
-(void)sendMessage:(NSString*)message;
-(void)close;

@end
