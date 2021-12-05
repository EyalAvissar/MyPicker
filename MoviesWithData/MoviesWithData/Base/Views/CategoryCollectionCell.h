//
//  CategoryCollectionCell.h
//  MoviesWithData
//
//  Created by inmanage on 05/12/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCollectionCell : UICollectionViewCell

+(NSString *)identifier;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)configureCell:(NSString *)category;
@end

NS_ASSUME_NONNULL_END
