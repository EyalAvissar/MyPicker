//
//  ArrayTransformer.m
//  NSSecureCodingProject
//
//  Created by inmanage on 02/12/2021.
//

#import "ArrayTransformer.h"

@implementation ArrayTransformer


    // Make sure `CustomClass` is in the allowed class list,
    // AND any other classes that are encoded in `CustomClass`

+ (NSArray<Class> *)allowedTopLevelClasses {
    return @[[ArrayTransformer class], [NSArray class]];
}

    /// Registers the transformer.
+(void)register{
    ArrayTransformer *transformer = [ArrayTransformer new];
    [NSValueTransformer setValueTransformer:transformer forName:[ArrayTransformer class]];
}
@end
