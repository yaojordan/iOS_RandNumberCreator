//
//  NumberCreate.h
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2016/12/23.
//  Copyright © 2016年 JordanYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberCreate : NSObject
{
    int numA;
    int numB;
    int result;
    
}
@property int numA;
@property int numB;
@property int result;

-(int)Create;

@end
