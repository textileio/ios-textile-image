//
//  TextileImage.m
//  Expecta
//
//  Created by Aaron Sutula on 3/27/19.
//

#import "TextileImage.h"
#import <Textile/TextileApi.h>

@implementation TextileImage

- (instancetype)initWithTarget:(NSString *)target index:(int)index minWidth:(int)minWidth {
  if (self = [super init]) {
    [self renderTarget:target index:index minWidth:minWidth];
  }
  return self;
}

- (void)renderTarget:(NSString *)target index:(int)index minWidth:(int)minWidth {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSError *error;
    UIImage *image;
    NSString *jsonString;
    NSString *path = [NSString stringWithFormat:@"%@/%d", target, index];
    jsonString = [Textile.instance.files imageDataForMinWidth:path minWidth:minWidth error:&error];
    if (jsonString) {
      NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
      NSError *error;
      id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
      NSDictionary *dict = (NSDictionary *)json;
      NSString *urlString = [dict objectForKey:@"url"];
      NSURL *url = [NSURL URLWithString:urlString];
      NSData *imageData = [NSData dataWithContentsOfURL:url];
      image = [UIImage imageWithData:imageData scale:1];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      if (error) {
        if (self.onError) {
          self.onError(error);
        }
      } else {
        super.image = image;
        if (self.onLoad) {
          self.onLoad();
        }
      }
    });
  });
}

@end
