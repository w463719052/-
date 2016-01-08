//
//  YGTimeQuantumChooseView.h
//  测试
//
//  Created by zccl2 on 16/1/8.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGTimeQuantumChooseViewDelegate <NSObject>

- (void)YGTimeQuantumChooseViewTimeChooseButtonPress;

@end

@interface YGTimeQuantumChooseView : UIView

@property (nonatomic,assign) id<YGTimeQuantumChooseViewDelegate>delegate;


- (void)timeChooseButtonSetTitle:(NSString *)title;

@end
