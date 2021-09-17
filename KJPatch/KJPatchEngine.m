//
//  KJPatchEngine.m
//  KJPatch
//
//  Created by Jack on 2021/9/17.
//

#import "KJPatchEngine.h"
#import "KJPatchExtension.h"
#import "KJPatchClass.h"
#import "KJPatchUserData.h"

@implementation KJPatchEngine

+ (void)startEngine {
    
    //启动虚拟机，加载标准库
    lua_State * L = kj_currentLuaState();
    luaL_openlibs(L);
    
    
    kj_setUpClass(L);//初始化注册class的查找，和 调用
    kj_setupUserdata(L);//初始化userdata环境，提供lua/oc交互数据的封装
    
}

@end
