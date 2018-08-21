//
//  WLFormIdCardImageCell.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormIdCardImageCell.h"
#import "WLFormItem.h"
#import "WLFormCompat.h"


static NSString *image_cell_id = @"image_card_cell_id";
static CGFloat const WL_ImageWidth = 58.0f;
static NSInteger const WL_RowImageCount = 2;

/**
 删除图标宽高
 */
static CGFloat const WLDeleteIconWidth = 22.0f;
/**
 删除按钮宽高，大于图标宽高，增强交互性
 */
static CGFloat const WLDeleteBtnWidth = 25.0f;


@interface WLFormIdCardImageCell ()

//正面
@property (nonatomic, strong) UIImageView * justImage;
@property (nonatomic, strong) UILabel * justLabel;
@property (nonatomic, strong) UIImageView * justDelIcon;
@property (nonatomic, strong) UIButton * justDelBtn;


//反面
@property (nonatomic, strong) UIImageView * reverseImage;
@property (nonatomic, strong) UILabel * reverseLabel;
@property (nonatomic, strong) UIImageView * reverseDelIcon;
@property (nonatomic, strong) UIButton * reverseDelBtn;



@property (nonatomic, strong) NSMutableArray *mutableImages;



@end

@implementation WLFormIdCardImageCell

- (void)setItem:(WLFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    if (item.images) {
        self.justDelIcon.hidden = NO;
        self.reverseDelIcon.hidden = NO;
    }else{
        self.justDelIcon.hidden = YES;
        self.reverseDelIcon.hidden = YES;
    }
    self.mutableImages = [NSMutableArray arrayWithArray:item.images];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(WL_EdgeMargin, WL_EdgeMargin, WL_TitleWidth, 20);
    
    self.justImage = [[UIImageView alloc]initWithFrame:CGRectMake(31, self.titleLabel.frame.origin.y+12, 58, 58)];
    self.justImage.image = [UIImage imageNamed:WL_AddIcon];
    self.justImage.clipsToBounds = YES;
    self.justImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.justImage];
    
    
    self.justLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, self.justImage.frame.origin.y, 58, 58)];
    self.justLabel.text = @"身份证正面";
    self.justLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.justLabel];
    
    self.justDelIcon = [[UIImageView alloc]initWithFrame:CGRectMake(31+self.justImage.frame.size.width-WLDeleteIconWidth/2, self.titleLabel.frame.origin.y+1, WLDeleteIconWidth, WLDeleteIconWidth)];
    self.justDelIcon.image = [UIImage imageNamed:WL_DeleteIcon];
    [self.contentView addSubview:self.justDelIcon];
    
    self.justDelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.justDelBtn.frame = CGRectMake(31+self.justImage.frame.size.width-WLDeleteBtnWidth/2, self.titleLabel.frame.origin.y, WLDeleteBtnWidth, WLDeleteBtnWidth);
    [self.justDelBtn addTarget:self action:@selector(justDeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.justDelBtn];
    
    //反面
    self.reverseImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.justImage.frame.origin.x+30, self.titleLabel.frame.origin.y+12, 58, 58)];
    self.reverseImage.image = [UIImage imageNamed:WL_AddIcon];
    self.reverseImage.clipsToBounds = YES;
    self.reverseImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.reverseImage];
    
    self.reverseLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.justImage.frame.origin.x+30, self.justImage.frame.origin.y, 58, 58)];
    self.reverseLabel.text = @"身份证反面";
    self.reverseLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.reverseLabel];
    
    self.reverseDelIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.justImage.frame.origin.x+30+self.reverseImage.frame.size.width-WLDeleteIconWidth/2, self.titleLabel.frame.origin.y+1, WLDeleteIconWidth, WLDeleteIconWidth)];
    self.reverseDelIcon.image = [UIImage imageNamed:WL_DeleteIcon];
    [self.contentView addSubview:self.reverseDelIcon];
    
    self.reverseDelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.reverseDelBtn.frame = CGRectMake(self.justImage.frame.origin.x+30+self.reverseImage.frame.size.width-WLDeleteBtnWidth/2, self.titleLabel.frame.origin.y, WLDeleteBtnWidth, WLDeleteBtnWidth);
    [self.reverseDelBtn addTarget:self action:@selector(reverseDeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.reverseDelBtn];
    
    
}

- (void)justDeleteAction {
    if (self.justdeleteImageCompletion) {
        self.justDelIcon.image = [UIImage imageNamed:WL_DeleteIcon];
        self.justdeleteImageCompletion();
    }
}

- (void)reverseDeleteAction {
    if (self.ReversedeleteImageCompletion) {
        self.reverseImage.image = [UIImage imageNamed:WL_AddIcon];
        self.ReversedeleteImageCompletion();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//@implementation UITableView (WLFormImageCell)
//
//- (WLFormImageCell *)imageCellWithId:(NSString *)cellId
//{
//    WLFormImageCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[WLFormImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.expandableTableView = self;
//    }
//    return cell;
//}
//@end
