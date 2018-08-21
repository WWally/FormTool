//
//  FormViewController.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/17.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "FormViewController.h"
#import "WLForm.h"
#import "WLFormHandler.h"
#import "CGXPickerView.h"

typedef void(^GenderSelectCompletion)(NSInteger index);

@interface FormViewController ()

@property (nonatomic, copy) GenderSelectCompletion genderSelectCompletion;
@property (nonatomic, strong) NSArray *genders;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.genders = @[@"男",@"女"];
    [self datas];
}

/**
 数据源处理
 */
- (void)datas {
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *items1 = [NSMutableArray array];
    NSMutableArray *items2 = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    WLFormItem *name = WLFormItem_Add(@"姓名", nil,@"请输入姓名", WLFormItemTypeInput, YES, NO, UIKeyboardTypeDefault);
    name.showLength = YES;
    [items addObject:name];
    
    WLFormItem *age = WLFormItem_Add(@"年龄", nil,@"请选择年龄", WLFormItemTypeSelect, YES, NO, UIKeyboardTypeDefault);
    age.itemSelectCompletion = ^(WLFormItem *item) {
        NSString *defaultSelValue = [[CGXPickerView showStringPickerDataSourceStyle:CGXStringPickerViewStyleAge] objectAtIndex:3];
        [CGXPickerView showStringPickerWithTitle:@"年龄" DefaultSelValue:defaultSelValue IsAutoSelect:YES Manager:nil ResultBlock:^(id selectValue, id selectRow) {
            item.info = selectValue;
            [weakSelf.formTableView reloadData];
        } Style:CGXStringPickerViewStyleAge];
    };
    age.maxInputLength = 3;
//    age.unit = @"岁";
    [items addObject:age];
    
    WLFormItem *price = WLFormItem_Add(@"体重", nil,@"请输入体重", WLFormItemTypeInput, YES, NO, UIKeyboardTypeNumberPad);
    price.maxInputLength = 3;
//    price.itemUnitType = WLFormItemUnitTypeYuan;
    [items addObject:price];
    
    WLFormItem *gender = WLFormItem_Add(@"性别", nil,@"请选择性别", WLFormItemTypeSelect, NO, NO, UIKeyboardTypeDefault);
    gender.itemSelectCompletion = ^(WLFormItem *item) {
        NSString *defaultSelValue = [[CGXPickerView showStringPickerDataSourceStyle:CGXStringPickerViewStyleGender] objectAtIndex:1];
        [CGXPickerView showStringPickerWithTitle:@"性别" DefaultSelValue:defaultSelValue IsAutoSelect:YES Manager:nil ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            item.info = selectValue;
            [weakSelf.formTableView reloadData];
        } Style:CGXStringPickerViewStyleGender];
    };
    [items addObject:gender];
    
    WLFormItem *intro = WLFormItem_Add(@"个人简介", @"这是个人简介",@"请输入个人简介", WLFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    intro.showLength = YES;
    [items1 addObject:intro];
    

    
    WLFormSectionItem *sectionItem = WLSectionItem(items);
    WLFormSectionItem *sectionItem1 = WLSectionItem(items1);
    //    SWFormSectionItem * section = SWSectionItem([NSArray arrayWithObjects:items,items1,items2, nil]);
    
    sectionItem.headerHeight = 10;
    sectionItem1.headerHeight = 10;
    //    sectionItem.footerHeight = 80;
    [self.mutableItems addObject:sectionItem];
    [self.mutableItems addObject:sectionItem1];
    
    self.formTableView.tableFooterView = [self footerView];
    

    
    // 确定按钮点击事件回调
    self.submitCompletion = ^{
        
        NSLog(@"提交按钮点击");
        // 这里只是简单描述校验逻辑，可根据自身需求封装数据校验逻辑
        [WLFormHandler wl_checkFormNullDataWithWithDatas:weakSelf.mutableItems success:^{            //NSLog(@"images === %@", image.images);
            NSLog(@"gender === %@", gender.info);
            NSLog(@"name === %@", name.info);
            
        } failure:^(NSString *error) {
            NSLog(@"error====%@",error);
        }];
    };
}


/**
 创建footer
 */
- (UIView *)footerView {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.bounds = CGRectMake(0, 0, 100, 40);
    submitBtn.center = footer.center;
    submitBtn.backgroundColor = [UIColor orangeColor];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:submitBtn];
    
    return footer;
}

- (void)submitAction {
    self.submitCompletion();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
