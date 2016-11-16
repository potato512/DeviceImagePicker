//
//  ViewController.m
//  DemoImagePhoto
//
//  Created by zhangshaoyu on 15/4/22.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYImagePickerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) SYImagePickerViewController *imagePicker;

@property (nonatomic, strong) UIImageView *mainImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"imagePicker";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStyleDone target:self action:@selector(photoClearClick:)];
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"拍照" style:UIBarButtonItemStyleDone target:self action:@selector(photoTakeClick:)];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(photoAlbumClick:)];
    self.navigationItem.rightBarButtonItems = @[btn1, btn2];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 创建视图

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, (self.view.frame.size.width - 20.0 * 2), (self.view.frame.size.height - 20.0 * 2))];
    [self.view addSubview:self.mainImageView];
    self.mainImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mainImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (!self.imagePicker)
    {
        self.imagePicker = [[SYImagePickerViewController alloc] init];
    }
}

#pragma mark - 响应事件

- (void)photoClearClick:(UIBarButtonItem *)button
{
    self.mainImageView.image = nil;
}

- (void)photoTakeClick:(UIBarButtonItem *)button
{
    self.imagePicker.pickerSourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([self.imagePicker isValidWithPickerSourceType])
    {
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
        
        ViewController __weak *weakSelf = self;
        [self.imagePicker getPickerImage:^(UIImage *image) {
            weakSelf.mainImageView.image = image;
        } error:^{
            
        } PhotosAlbum:NO saveStart:^{
            
        } saveFinish:^(SavePhotoStatus status) {
            
        }];
    }
}

- (void)photoAlbumClick:(UIBarButtonItem *)button
{
    self.imagePicker.pickerSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   
    if ([self.imagePicker isValidWithPickerSourceType])
    {
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
        
        ViewController __weak *weakSelf = self;
        [self.imagePicker getPickerImage:^(UIImage *image) {
            weakSelf.mainImageView.image = image;
        } error:^{
            
        } PhotosAlbum:NO saveStart:^{
            
        } saveFinish:^(SavePhotoStatus status) {
            
        }];
    }
}

@end
