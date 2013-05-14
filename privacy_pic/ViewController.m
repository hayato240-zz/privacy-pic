//
//  ViewController.m
//  privacy_pic
//
//  Created by nishimaru hayato on 2013/05/14.
//  Copyright (c) 2013年 nishimaru hayato. All rights reserved.
//

#import "ViewController.h"
#import "resultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerController:(UIImagePickerController*)picker
         didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary*)editingInfo {
    
    _originalImage.image = image;
    [picker dismissModalViewControllerAnimated:YES]; 
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
        result.myimage =_originalImage.image;
    }
}

@end
