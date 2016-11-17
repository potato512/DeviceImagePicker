//
//  SYImagePickerQBViewController.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/11.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYImagePickerQBViewController.h"

@interface SYImagePickerQBViewController () <QBImagePickerControllerDelegate>

@property (nonatomic, copy) void (^succeedBack)(NSArray *images); // 设置代码块属性-成功
@property (nonatomic, copy) void (^errorBack)(void);              // 设置代码块属性-失败

@end

@implementation SYImagePickerQBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initImageQBPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化

- (void)initImageQBPicker
{
    self.delegate = self;
//    self.mediaType = QBImagePickerMediaTypeAny;
//    self.allowsMultipleSelection = YES;
//    self.showsNumberOfSelectedAssets = YES;
}

#pragma mark - methord

/// 设置代码块回调函数
- (void)getPickerImage:(void (^)(NSArray *images))succeed error:(void (^)(void))error
{
    self.succeedBack = succeed;
    self.errorBack = error;
}

#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if ([info isKindOfClass:[NSArray class]])
    {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in (NSArray *)info)
        {
            UIImage *image = [dict objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            [images addObject:image];
        }
        
        if (self.succeedBack)
        {
            self.succeedBack(images);
        }
    }
    else
    {
        if (self.errorBack)
        {
            self.errorBack();
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    if (self.errorBack)
    {
        self.errorBack();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    NSString *title = [[NSString alloc] initWithFormat:@"%ld张相片", numberOfPhotos];
    return title;
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    NSString *title = [[NSString alloc] initWithFormat:@"%ld个视频", numberOfVideos];
    return title;
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    NSString *title = [[NSString alloc] initWithFormat:@"%ld张相片，%ld个视频", numberOfPhotos, numberOfVideos];
    return title;
}

@end
