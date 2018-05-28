//
//  SYImagePickerQBViewController.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/11.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  图片多选操作

#import "QBImagePickerController.h"

@interface SYImagePickerQBViewController : QBImagePickerController

/// 设置代码块回调函数
- (void)getPickerImage:(void (^)(NSArray *images))succeed error:(void (^)(void))error;

@end


/*
 
 使用说明
 
 // 导入头文件，及定义属性
 // 初始化
 self.imageQBPicker = [[ImageQBPickerBlockVC alloc] init];
 // 是否允许多选时限制最小个数
 self.imageQBPicker.limitsMaximumNumberOfSelection = YES;
 // 相册类型
 self.imageQBPicker.filterType = QBImagePickerFilterTypeAllPhotos;
 // 是否允许多选时限制最大个数
 self.imageQBPicker.allowsMultipleSelection = YES;
 // 多选时最大个数
 self.imageQBPicker.maximumNumberOfSelection = 10;
 // 多选结果回调
 [self.imageQBPicker getPickerImage:^(NSArray *images) {
    
    NSLog(@"images %@", images);
    // 如果有引用其他属性，注意弱引用（避免循环引用，导致内存未释放）
 
 } error:^{
 
 }];
 // 视图跳转
 UINavigationController *navMoreQB = [[UINavigationController alloc] initWithRootViewController:self.imageQBPicker];
 [self presentViewController:navMoreQB animated:YES completion:NULL];

 
 */