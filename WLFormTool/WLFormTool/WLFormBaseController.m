//
//  WLFormBaseController.m
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseController.h"
#import "WLForm.h"
#import "WLFormInputCell.h"
#import "WLFormTextViewInputCell.h"
#import "WLFormSelectCell.h"
#import "WLFormCompat.h"

@interface WLFormBaseController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly) UITableViewStyle style;
@end

@implementation WLFormBaseController

- (NSMutableArray *)mutableItems {
    if (!_mutableItems) {
        _mutableItems = [[NSMutableArray alloc]init];
    }
    return _mutableItems;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:_style];
    [self addChildViewController:tableViewController];
    [tableViewController.view setFrame:self.view.bounds];
    
    // 获取tableViewController的tableView实现表单自动上移
    _formTableView = tableViewController.tableView;
    _formTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _formTableView.dataSource = self;
    _formTableView.delegate = self;
    //_formTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _formTableView.showsVerticalScrollIndicator = NO;
    _formTableView.showsHorizontalScrollIndicator = NO;
    _formTableView.backgroundColor = [UIColor whiteColor];
    _formTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGFLOAT_MIN)];
    _formTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGFLOAT_MIN)];
    _formTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    //  加上这句不会影响你 tableview 上的 action (button,cell selected...)
    singleTap.cancelsTouchesInView = NO;
    [_formTableView addGestureRecognizer:singleTap];
    
    [self.view addSubview:_formTableView];
}

- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert([self.mutableItems[section] isKindOfClass:[WLFormSectionItem class]]);
    WLFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
//    NSParameterAssert([[sectionItem.items[indexPath.section] objectAtIndex:indexPath.row] isKindOfClass:[WLFormItem class]]);
//    WLFormItem *item = [sectionItem.items[indexPath.section] objectAtIndex:indexPath.row];
    NSParameterAssert([sectionItem.items[indexPath.row] isKindOfClass:[WLFormItem class]]);
    WLFormItem * item = sectionItem.items[indexPath.row];
    // 表单条目类别判断
    if (item.itemType == WLFormItemTypeTextViewInput) {
        static NSString *textViewInput_cell_id = @"textViewInput_cell_id";
        WLFormTextViewInputCell *cell = [tableView textViewInputCellWithId:textViewInput_cell_id];
        cell.item = item;
        cell.textViewInputCompletion = ^(NSString *text) {
            [self updateTextViewInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
    else if (item.itemType == WLFormItemTypeSelect) {
        static NSString *select_cell_id = @"select_cell_id";
        WLFormSelectCell *cell = [tableView selectCellWithId:select_cell_id];
        cell.item = item;
        return cell;
    }
//    else if (item.itemType == WLFormItemTypeImage) {
//        static NSString *image_cell_id = @"image_cell_id";
//        WLFormImageCell *cell = [tableView imageCellWithId:image_cell_id];
//        cell.item = item;
//        cell.imageCompletion = ^(NSArray *images) {
//            [self updateImageWithImages:images indexPath:indexPath];
//        };
//        return cell;
//    }
    else {
        static NSString *input_cell_id = @"input_cell_id";
        WLFormInputCell *cell = [tableView inputCellWithId:input_cell_id];
        cell.item = item;
        cell.inputCompletion = ^(NSString *text) {
            [self updateInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
}

#pragma mark -- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
//    WLFormItem *item = [sectionItem.items[indexPath.section] objectAtIndex:indexPath.row];
    WLFormItem * item = sectionItem.items[indexPath.row];
    if (item.itemType == WLFormItemTypeTextViewInput) {
        return [WLFormTextViewInputCell heightWithItem:item];
    }
    else if (item.itemType == WLFormItemTypeSelect) {
        return [WLFormSelectCell heightWithItem:item];
    }
//    else if (item.itemType == WLFormItemTypeImage) {
//        return [WLFormImageCell heightWithItem:item];
//    }
    else if (item.itemType == WLFormItemTypeAddress)
    {
        return [WLFormSelectCell heightWithItem:item];
    }
    else {
        return [WLFormInputCell heightWithItem:item];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    WLFormItem *item = sectionItem.items[indexPath.row];
    if (item.itemType == WLFormItemTypeSelect && item.itemSelectCompletion) {
        item.itemSelectCompletion(item);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WLFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.headerHeight > 0 ? sectionItem.headerHeight:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    WLFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.footerHeight > 0 ? sectionItem.footerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WLFormSectionItem *sectionItem = self.mutableItems[section];
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, sectionItem.headerHeight)];
    header.backgroundColor =  UIColorFromRGB(0xF7F7F7);
    return sectionItem.headerView ? sectionItem.headerView:header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WLFormSectionItem *sectionItem = self.mutableItems[section];
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, sectionItem.footerHeight)];
    footer.backgroundColor =  UIColorFromRGB(0xF7F7F7);
    return sectionItem.footerView ? sectionItem.footerView:footer;
}

#pragma mark -- 表单条目响应block处理
- (void)updateInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    WLFormItem *item = sectionItem.items[indexPath.row];
    item.info = text;
}

- (void)updateTextViewInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    WLFormItem *item = sectionItem.items[indexPath.row];
    item.info = text;
}

- (void)updateImageWithImages:(NSArray *)images indexPath:(NSIndexPath *)indexPath {
    WLFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    WLFormItem *item = sectionItem.items[indexPath.row];
    item.images = images;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
