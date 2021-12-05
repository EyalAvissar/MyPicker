//
//  CategoryCollectionCell.m
//  MoviesWithData
//
//  Created by inmanage on 05/12/2021.
//

#import "CategoryCollectionCell.h"

@implementation CategoryCollectionCell

+ (NSString *)identifier {
    return @"CategoryCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCell:(NSString *)category {
    self.categoryLabel.text = category;
    
    self.backgroundColor = [UIColor lightGrayColor];
}



@end
