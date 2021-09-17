//
//  ViewController.m
//  Lua_OC
//
//  Created by Jack on 2021/9/14.
//

#import "ViewController.h"
#import <PatchCore/PatchCore.h>

#import <KJPatch/KJPatch.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CFAbsoluteTime begin = CFAbsoluteTimeGetCurrent();
    
    //启动引擎
    [CrossTest start];
    
    //测试加载lua
    NSString * path = [[NSBundle mainBundle] pathForResource:@"luatest" ofType:@"lua"];
    [CrossTest loadFileInPath:path];
    
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"pacthcore耗时=========== %0.5f",end - begin);

    //调用原生
    
}


@end
