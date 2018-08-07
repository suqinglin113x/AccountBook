//
//  NSObject+HUD.h
//  qisudai
//
//  Created by wzh on 17/3/14.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (HUD)
//+ (void)showHint_object:(NSString *)hint;
- (void)show_objectHudInView:(UIView *)view hint:(NSString *)hint;
- (void)hideHudInView:(UIView *)view;
- (void)showHint_object:(NSString *)hint;
- (void)showHint_object:(NSString *)hint yOffset:(float)yOffset;
- (void)showHint_object:(NSString *)hint yOffset:(float)yOffset andAfterDelay:(NSTimeInterval)delay view:(UIView *)view;
@end
