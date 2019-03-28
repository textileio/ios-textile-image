//
//  TextileImage.h
//  Expecta
//
//  Created by Aaron Sutula on 3/27/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextileImage : UIImageView

@property (nonatomic, copy, nullable) void (^onError)(NSError *);
@property (nonatomic, copy, nullable) void (^onLoad)(void);

- (instancetype)initWithTarget:(NSString *)target index:(int)index minWidth:(int)minWidth;

@end

NS_ASSUME_NONNULL_END
