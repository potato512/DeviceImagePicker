//
//  ViewController.m
//  DemoImagePhoto
//
//  Created by zhangshaoyu on 15/4/22.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYImagePicker.h"

@interface ViewController ()

@property (nonatomic, strong) SYImagePickerViewController *imagePicker;
@property (nonatomic, strong) SYImagePickerQBViewController *imageQBPicker;

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
    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithTitle:@"多图" style:UIBarButtonItemStyleDone target:self action:@selector(photoMoreClick:)];
    self.navigationItem.rightBarButtonItems = @[btn1, btn2, btn3];
    
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
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

#pragma mark - 创建视图

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, (self.view.frame.size.width - 20.0 * 2), (self.view.frame.size.height - 20.0 * 2))];
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
    [self removeAllImages];
}

- (void)removeAllImages
{
    for (NSInteger i = self.view.subviews.count - 1; i >= 0; i--)
    {
        UIView *subview = self.view.subviews[i];
        [subview removeFromSuperview];
    }
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
            if (weakSelf.mainImageView.superview == nil)
            {
                [self removeAllImages];
                [weakSelf.view addSubview:weakSelf.mainImageView];
            }
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
            if (weakSelf.mainImageView.superview == nil)
            {
                [self removeAllImages];
                [weakSelf.view addSubview:weakSelf.mainImageView];
            }
        } error:^{
            
        } PhotosAlbum:NO saveStart:^{
            
        } saveFinish:^(SavePhotoStatus status) {
            
        }];
    }
}

- (void)photoMoreClick:(UIBarButtonItem *)button
{
    if (self.imageQBPicker == nil)
    {
        self.imageQBPicker = [[SYImagePickerQBViewController alloc] init];
    }
    // 是否允许多选时限制最小个数
    self.imageQBPicker.limitsMaximumNumberOfSelection = YES;
    // 相册类型
    self.imageQBPicker.filterType = QBImagePickerFilterTypeAllPhotos;
    // 是否允许多选时限制最大个数
    self.imageQBPicker.allowsMultipleSelection = YES;
    // 多选时最大个数
    self.imageQBPicker.maximumNumberOfSelection = 10;
    // 多选结果回调
    ViewController __weak *weakSelf = self;
    NSInteger columnNumber = 3;
    CGFloat originXY = 10.0;
    CGFloat sizeImage = (CGRectGetWidth(self.view.bounds) - originXY * (columnNumber + 1)) / columnNumber;
    [self.imageQBPicker getPickerImage:^(NSArray *images) {
        
        NSLog(@"images %@", images);
        
        // 如果有引用其他属性，注意弱引用（避免循环引用，导致内存未释放）
        [weakSelf removeAllImages];
        for (int i = 0; i < images.count; i++)
        {
            CGRect rect = CGRectMake((i % columnNumber * (originXY + sizeImage) + originXY), (i / columnNumber * (originXY + sizeImage) + originXY), sizeImage, sizeImage);
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
            [weakSelf.view addSubview:imageview];
            imageview.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            imageview.image = images[i];
        }
        
    } error:^{
        
    }];
    // 视图跳转
    UINavigationController *navMoreQB = [[UINavigationController alloc] initWithRootViewController:self.imageQBPicker];
    [self presentViewController:navMoreQB animated:YES completion:NULL];
}

@end
