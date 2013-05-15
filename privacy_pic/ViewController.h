//
//  ViewController.h
//  privacy_pic
//
//  Created by nishimaru hayato on 2013/05/14.
//  Copyright (c) 2013年 nishimaru hayato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)touchImageButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBtn;
@property (strong, nonatomic) IBOutlet UIImageView *originalImage;
@property (weak, nonatomic) IBOutlet UIImageView *stampImage;
@end
