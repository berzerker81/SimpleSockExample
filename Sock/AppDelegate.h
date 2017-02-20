//
//  AppDelegate.h
//  Sock
//
//  Created by jangwoong on 2017. 2. 20..
//  Copyright © 2017년 SELQA_macbookpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

