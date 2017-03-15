//
//  ViewController.m
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2016/9/5.
//  Copyright © 2016年 JordanYao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize NumDisplay, NumA, NumB;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cr = [NumberCreate new];
    
    //load時就讓他讀數字鍵盤
    NumA.keyboardType=UIKeyboardTypeNumberPad;
    NumB.keyboardType=UIKeyboardTypeNumberPad;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
} //點擊空白處關閉鍵盤

-(void)JumpAlert{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"" message:@"尚未輸入數字" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
        //按鈕按下去之後執行的動作
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //把確定按鈕加到controller
    [alert addAction:alertAction];
    //顯示controller
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)NumA:(UITextField *)sender {
}
- (IBAction)NumB:(UITextField *)sender {
}

- (IBAction)CreateNum:(UIButton *)sender {

    cr.numA = [NumA.text intValue];
    cr.numB = [NumB.text intValue];
    int result=0;
    //int count;
    
    
    if( cr.numA==nil || cr.numB==nil ){
        [self JumpAlert];
    }
    else{
        result=[cr Create];
        NumDisplay.text=[NSString stringWithFormat:@"%d", result];
    }
    
}
- (IBAction)ResetNum:(UIButton *)sender {
    NumA.text = NULL;
    NumB.text = NULL;
    NumDisplay.text=@"0";
}

@end
