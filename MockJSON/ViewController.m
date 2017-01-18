//
//  ViewController.m
//  MockJSON
//
//  Created by caiyangjieto on 15/9/1.
//  Copyright (c) 2017年 jiulvxing. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utility.h"
#import "HTTPService.h"
#import "FileService.h"


@interface ViewController () <NSTableViewDelegate,NSTableViewDataSource>

@property (strong,nonatomic) NSTableView *tableView;
@property (strong,nonatomic) NSArray *arrayFileName;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initTextView];
    [self initTableView];
    
    [self initTableViewData];
    
    [_labelIP setStringValue:[NSString stringWithFormat:@"本机IP：%@",[HTTPService getNativeIP]]];
    
}

- (void)setRepresentedObject:(id)representedObject{
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (void)initTextView
{
    _textView.automaticQuoteSubstitutionEnabled = NO;//禁止引号自动中英文变换
    _textView.automaticDashSubstitutionEnabled = NO;
    _textView.automaticTextReplacementEnabled = NO;
}

- (void)initTableView
{
    _tableView = [[NSTableView alloc] initWithFrame:_listView.frame];
    NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"column1"];
    [column1 setTitle:@"  ***接口名称***"];
    [column1 setWidth:_listView.frame.size.width];
    // generally you want to add at least one column to the table view.
    [_tableView addTableColumn:column1];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setTarget:self];
    [_tableView setAction:@selector(selectClick:)];
    [_tableView setGridStyleMask:NSTableViewDashedHorizontalGridLineMask];
    [_tableView reloadData];
    // embed the table view in the scroll view, and add the scroll view to our window.
    [_listView setDocumentView:_tableView];
    [_listView setHasVerticalScroller:YES];
}

- (void)initTableViewData
{
    NSString *strSiteRoot = [FileService cacheJSONPath];;
    _arrayFileName = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:strSiteRoot error:nil];
}

- (void)refreshFileList
{
    double delayInSeconds = 0.5;
    @WeakObj(self)
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        @StrongObj(self)
        if (selfStrong)
        {
            [selfStrong initTableViewData];
            [selfStrong.tableView reloadData];
        }
    });
}

#pragma mark - 界面button响应

/**
 * 界面响应函数－保存修改
 */
- (IBAction)saveModifyHistory:(id)sender
{
    [self saveJsonToFile:_textTitle.stringValue];
    [self refreshFileList];
}

- (void)saveJsonToFile:(NSString *)fileName
{
    [_textView setBackgroundColor:[NSColor whiteColor]];
    if(_textView.string == nil || [_textView.string jsonValidate] == NO){
        [_textView setDrawsBackground:YES];
        [_textView setBackgroundColor:[NSColor orangeColor]];
    }
    else{
        _textView.string = [_textView.string formatString];
    }
    
    [FileService saveText:_textView.string toFile:fileName];
}

/**
 * 删除站点接口文件
 */
- (IBAction)deleteHistory:(id)sender
{
    NSInteger rowNumber = [_tableView selectedRow];
    if (rowNumber < 0 && rowNumber >= [_arrayFileName count])
        return;
    
    NSString *strFileName = [_arrayFileName objectAtIndex:rowNumber];
    [FileService removeFileName:strFileName];
    [self refreshFileList];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_arrayFileName count];
}

- (id)tableView:(NSTableView*)tableView objectValueForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row
{
    return [_arrayFileName objectAtIndex:row];
}

- (void)selectClick:(id)sender
{
    NSInteger rowNumber = [_tableView clickedRow];
    if (rowNumber >= [_arrayFileName count])
        return;
    
    NSString *title = [_arrayFileName objectAtIndex:rowNumber];
    [self readLocalJson:title];
    [_textView setBackgroundColor:[NSColor whiteColor]];
}

- (void)readLocalJson:(NSString *)fileName
{
    NSString *content = [FileService readLocalFile:fileName];
    _textView.string = content.length>0?content:@"";
    _textTitle.stringValue = fileName;
}

@end
