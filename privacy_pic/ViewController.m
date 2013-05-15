//
//  ViewController.m
//  privacy_pic
//
//  Created by nishimaru hayato on 2013/05/14.
//  Copyright (c) 2013年 nishimaru hayato. All rights reserved.
//

#import "ViewController.h"
#import "resultViewController.h"
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

CGRect faceRectData;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectStamp;
@property (strong, nonatomic) UIImage *rubyImage;
@property (strong, nonatomic) UIImage *pythonImage;
@property (strong, nonatomic) UIImageView *addImage;
@property (strong ,nonatomic) NSArray *faceData;

@end


@implementation ViewController

- (void)viewDidLoad
{
    _rubyImage = [UIImage imageNamed:@"ruby.png"];
    _pythonImage = [UIImage imageNamed:@"python.png"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 撮影画像を取得
    UIImage *pickerImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];

    // 撮影した写真をUIImageViewへ設定
    _originalImage.image = pickerImage;
    NSLog(@" -- size %f ", pickerImage.size.width);
    
    // 検出器生成
    NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    
    // 検出
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:pickerImage.CGImage];
    NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:6] forKey:CIDetectorImageOrientation];
//    NSArray *array = [detector featuresInImage:ciImage options:imageOptions];
    _faceData = [detector featuresInImage:ciImage options:imageOptions];
    
    // 検出されたデータを取得
    for (CIFaceFeature *faceFeature in _faceData) {
        // 眼鏡画像追加処理へ
        [self drawMeganeImage:faceFeature];
    }
        
    // カメラUIを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)drawMeganeImage:(CIFaceFeature *)faceFeature
{
   
    if (faceFeature.hasLeftEyePosition && faceFeature.hasRightEyePosition && faceFeature.hasMouthPosition) {
        
        // 顔のサイズ情報を取得
        CGRect faceRect = [faceFeature bounds];
                NSLog(@"++++===============%lf, %lf",faceRect.origin.x, faceRect.origin.y);        // 写真の向きで検出されたXとYを逆さにセットする
        float temp = faceRect.size.width;
        faceRect.size.width = faceRect.size.height;
        faceRect.size.height = temp;
        temp = faceRect.origin.x;
        faceRect.origin.x = faceRect.origin.y;
        faceRect.origin.y = temp;
        
        // 比率計算
        float widthScale = _originalImage.frame.size.width / _originalImage.image.size.width;
        float heightScale = _originalImage.frame.size.height / _originalImage.image.size.height;
        // 眼鏡画像のxとy、widthとheightのサイズを比率似合わせて変更
        faceRect.origin.x *= widthScale;
        faceRect.origin.y *= heightScale;
        faceRect.size.width *= widthScale;
        faceRect.size.height *= heightScale;
        
        UIImage *glassesImage = [UIImage imageNamed:@"ruby.png"];
        UIImageView *glassesImageView = [[UIImageView alloc]initWithImage:glassesImage];
        glassesImageView.frame = faceRect;
        
        // 眼鏡レイヤを撮影した写真に重ねる
//        [_originalImage addSubview:glassesImageView];
        
    }
}

- (IBAction)touchImageButton:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    resultViewController *result = [segue destinationViewController];
    
    if([[segue identifier] isEqualToString:@"toResult"]){
        //result.resultImage.image = _originalImage.image;
        result.myimage =_originalImage;
//        CGRect faceRect = [_faceData[0] bounds];
//        NSLog(@"++++===============%lf, %lf",faceRect.origin.x, faceRect.origin.y);        // 写真の向きで検出されたXとYを逆さにセットする
        
        result.faceRects = _faceData;
        result.segmentBtn = _segmentBtn;
    }
}


@end
