//
//  AppDelegate.m
//  ClipboardObserver
//
//  Created by 河野 さおり on 2016/04/18.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    IBOutlet NSTextView *_txtView;
    IBOutlet NSImageView *_imgView;
}
@property (weak) IBOutlet NSWindow *window;
@property (strong) ClipboardObserver *clipboardObserver;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setUpNotification];
}

//ノーティフィケーションを設定
- (void)setUpNotification{
    _clipboardObserver = [[ClipboardObserver alloc]init];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"NSPasteboardDidChange" object:_clipboardObserver queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notif){
        //受け取り時処理
        NSPasteboard *pboard = [NSPasteboard generalPasteboard];
        NSArray *imgClass = [NSArray arrayWithObject:[NSImage class]];
        if ([pboard canReadObjectForClasses:imgClass options:nil]) {
            NSImage *img = [[pboard readObjectsForClasses:imgClass options:nil]objectAtIndex:0];
            [_txtView setString:@""];
            [_imgView setImage:img];
        }
        NSArray *strClass = [NSArray arrayWithObject:[NSString class]];
        if ([pboard canReadObjectForClasses:strClass options:nil]) {
            NSString *str = [[pboard readObjectsForClasses:strClass options:nil]objectAtIndex:0];
            [_imgView setImage:nil];
            [_txtView setString:str];
        }
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

@end
