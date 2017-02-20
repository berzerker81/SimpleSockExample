//
//  Sock.m
//  Sock
//
//  Created by jangwoong on 2017. 2. 20..
//  Copyright © 2017년 SELQA_macbookpro. All rights reserved.
//

#import "Sock.h"

@implementation Sock

-(id)initWithSockAddress:(NSString*)target port:(UInt32)port
{
    self = [super init];
    
    if(self)
    {
        [self initNetworkCommunication:target port:port];
        
    }
    
    return self;
    
}

-(void)initNetworkCommunication:(NSString*)target port:(UInt32)port
{
    
    [self close];
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStringRef ref = (__bridge CFStringRef)(target);
    
    CFStreamCreatePairWithSocketToHost(NULL, ref, port, &readStream, &writeStream);
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputStream = (__bridge NSOutputStream *)writeStream;

    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
    
}

-(void)sendMessage:(NSString*)message
{
    NSString * response = [NSString stringWithFormat:@"msg:%@",message];
    NSData * data       = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [_outputStream write:[data bytes] maxLength:[data length]];
    
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode)
    {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
        {
            if(aStream == _inputStream)
            {
                uint8_t buffer[1024]={0};
                NSInteger len;
                
                
                while ([_inputStream hasBytesAvailable])
                {
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    
                    if(len > 0)
                    {
                        
                        NSString * output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if(output != nil)
                        {
                            [self messageReceived:output];
                        }
                        
                    }
                }
                
                
                
                
            }
            
        }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
        {
            [self close];
        }
            break;
            
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"Stream has space available now");
            break;
            
        default:
            NSLog(@"Unknown event");
    }
    

}


-(void)messageReceived:(NSString*)message
{
    NSLog(@"%@",message);
    
}

-(void)close
{
    [_inputStream close];
    [_outputStream close];
    
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    _inputStream.delegate = nil;
    _outputStream.delegate = nil;
    
    _inputStream = nil;
    _outputStream = nil;
    
}

@end
