//
//  ViewController.h
//  MockJSON
//
//  Created by caiyangjieto on 15/9/1.
//  Copyright (c) 2017年 jiulvxing. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet NSButton *buttonMock;
@property (strong) IBOutlet NSButton *buttonJSPatch;
@property (strong) IBOutlet NSButton *buttonSaveMock;
@property (strong) IBOutlet NSButton *buttonSaveJSPatch;

@property (strong) IBOutlet NSTextField *labelIP;
@property (strong) IBOutlet NSScrollView *listView;

@property (strong) IBOutlet NSTextView *textView;
@property (strong) IBOutlet NSTextField *textTitle;

@end

