# SYImagePickerViewController

##iPhone设备拍照和相册图片的使用方法封装
通常直接调用手机相册，或拍照时，设置使用代理较麻烦，所以封装成block模式进行使用，代码紧凑，且易于查看。

##使用示例
~~~ javascript
//步骤1 导入头文件
#import "SYImagePickerViewController.h"


// 步骤2 定义属性
@property (nonatomic, strong) SYImagePickerViewController *imagePicker;


// 步骤3 实例化
self.imagePicker = [[SYImagePickerViewController alloc] init];


// 步骤4 设置数据源
self.imagePicker.pickerSourceType = UIImagePickerControllerSourceTypePhotoLibrary;

// 步骤5 异常判断
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

```

# 效果图
![ImagePickerVC](./ImagePickerVC.gif)
 
