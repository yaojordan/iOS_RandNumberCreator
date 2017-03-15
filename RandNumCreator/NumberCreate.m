//
//  NumberCreate.m
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2016/12/23.
//  Copyright © 2016年 JordanYao. All rights reserved.
//

#import "NumberCreate.h"

@implementation NumberCreate
@synthesize numA, numB, result;

-(int)Create{

    result = arc4random() %  (numB-numA+1) + numA;
  
    return result;
}


@end
