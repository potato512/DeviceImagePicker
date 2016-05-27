# DeviceImagePicker

##iPhone设备拍照和相册图片的使用方法封装
通常直接调用手机相册，或拍照时，设置使用代理较麻烦，所以封装成block模式进行使用，代码紧凑，且易于查看。

##使用示例
```javascript
//步骤1 导入头文件
#import "ImagePickerBlockVC.h"
```

```javascript
// 步骤2 定义属性
@property (nonatomic, strong) ImagePickerBlockVC *imagePickerVC;
```

```javascript
// 步骤3 实例化
 self.imagePickerVC = [[ImagePickerBlockVC alloc] init];
```

```javascript
// 步骤4 设置数据源
self.imagePickerVC.pickerSourceType = UIImagePickerControllerSourceTypeCamera;
```

```javascript
// 步骤5 异常判断
if ([self.imagePickerVC isValidWithPickerSourceType])
{
    [self presentViewController:self.imagePickerVC animated:YES completion:NULL];
 
    [self.imagePickerVC getPickerImage:^(UIImage *image) {
        NSLog(@"get image success");
    } error:^{
        NSLog(@"get image error");
    } PhotosAlbum:isSave saveStart:^{
        NSLog(@"save image start");
    } saveFinish:^(SavePhotoStatus status) {
        NSLog(@"save image %@", (SavePhotoSuccess == status ? @"成功" : @"失败"));
    }];
}
 ```
 
