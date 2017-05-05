//
//  ViewController.m
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2016/9/5.
//  Copyright © 2016年 JordanYao. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
} //點擊空白處關閉鍵盤



- (IBAction)NumA:(UITextField *)sender {
}
- (IBAction)NumB:(UITextField *)sender {
}

- (IBAction)CreateNum:(UIButton *)sender {

    cr.numA = [NumA.text intValue];
    cr.numB = [NumB.text intValue];
    int result=0;
    //int count=0;
    
    if( cr.numA == nil || cr.numB == nil ){
        [self JumpAlert];
    }
    else if(cr.numA > 9999 || cr.numB > 9999){
        [self JumpAlert_TooBig];
    }
    else
    {
        result=[cr Create];
        NumDisplay.text=[NSString stringWithFormat:@"%d", result];
        
        
        //取用  Managed Object Context
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
        
        //新增 Managed Object
        NSManagedObject *Addnumber = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"Entity"
                                      inManagedObjectContext:managedObjectContext];
        [Addnumber setValue:NumDisplay.text forKey:@"number"]; // 設定屬性
        NSError *error = nil;
        if(![managedObjectContext save:&error]){
            NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);  // 要呼叫 save 才會儲存
        }
    }
    
}

- (IBAction)ResetNum:(UIButton *)sender {
    NumA.text = NULL;
    NumB.text = NULL;
    NumDisplay.text=@"0";
}


-(void)JumpAlert{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Oops!" message:@"尚未輸入數字" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"確定"style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
        //按鈕按下去之後執行的動作
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //把確定按鈕加到controller
    [alert addAction:alertAction];
    //顯示controller
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)JumpAlert_TooBig{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Oops!" message:@"僅限0~9999的數字" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"確定"style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
        //按鈕按下去之後執行的動作
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //把確定按鈕加到controller
    [alert addAction:alertAction];
    //顯示controller
    [self presentViewController:alert animated:YES completion:nil];
}

@end
