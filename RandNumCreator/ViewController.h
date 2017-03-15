//
//  ViewController.h
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2016/9/5.
//  Copyright © 2016年 JordanYao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCreate.h"

@interface ViewController : UIViewController
{
    NumberCreate *cr;
    __weak IBOutlet UILabel *NumDisplay;
    __weak IBOutlet UITextField *NumA;
    __weak IBOutlet UITextField *NumB;
}


@property (weak, nonatomic) IBOutlet UILabel *NumDisplay;
@property (weak, nonatomic) IBOutlet UITextField *NumA;
@property (weak, nonatomic) IBOutlet UITextField *NumB;

- (IBAction)CreateNum:(UIButton *)sender;
- (IBAction)ResetNum:(UIButton *)sender;


@end

