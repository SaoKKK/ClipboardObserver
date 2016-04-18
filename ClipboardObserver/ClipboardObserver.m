//
//  ClipboardObserver.m
//  ClipboardObserver
//
//  Created by 河野 さおり on 2016/04/18.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//  http://saokkk.seesaa.net/

#import "ClipboardObserver.h"

@implementation ClipboardObserver{
    NSInteger changeCount;
    NSTimer *timer;
}

- (id)init{
    self = [super init];
    if (self) {
        changeCount = 0;
        //タイマー開始（scheduledTimerWithTimeIntervalで監視間隔を指定）
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(observePboard) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)observePboard{
    NSPasteboard *pboard = [NSPasteboard generalPasteboard];
    if (pboard.changeCount != changeCount) {
        changeCount = pboard.changeCount;
       [[NSNotificationCenter defaultCenter] postNotificationName:@"NSPasteboardDidChange" object:self userInfo:nil];
    }
}

@end
