 使用示例
 步骤1 导入头文件
 #import "ImagePickerBlockVC.h"
 
 步骤2 定义属性
 @property (nonatomic, strong) ImagePickerBlockVC *imagePickerVC;
 
 步骤3 实例化
 self.imagePickerVC = [[ImagePickerBlockVC alloc] init];
 
 步骤4 设置数据源
 self.imagePickerVC.pickerSourceType = UIImagePickerControllerSourceTypeCamera;
 
 步骤5 异常判断
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
