//
//  KJPatchClass.m
//  KJPatch
//
//  Created by Jack on 2021/9/17.
//

#import <Foundation/Foundation.h>
#import "KJPatchClass.h"
#import "KJPatchHeader.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


#pragma mark - 特殊情况
// 在释放它们实例对象时, 需要先获取其retainCount, 在获取retainCount时会crash.
BOOL kj_cannotAccessClass(NSString *className) {
    static NSSet *blackList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        blackList = [NSSet setWithObjects:
                     @"NSProxy",
                     @"NSMessagePort",
                     @"NSInputStream",
                     @"NSOutputStream",
                     nil];
    });
    if ([blackList containsObject:className]) {
        return NO;
    }
    return YES;
}

BOOL kj_cannotAllocClass(lua_State *L, id target, const char *selectorName) {
    if (target == [NSCalendar class]) {
        if (KJ_CSTRING_EQUAL(selectorName, "alloc")) {
            return YES;
        }
        if (KJ_CSTRING_EQUAL(selectorName, "initWithCalendarIdentifier:")) {
            return YES;
        }
        if (KJ_CNSTRING_EQUAL(selectorName, "init", 4)) {
            lua_pushnil(L);
            return YES;
        }
    }
    
    if (target == [NSTimer class] || target == [UIFont class]) {
        if (KJ_CSTRING_EQUAL(selectorName, "alloc")) { // 这几个类不允许调用alloc/init方法,否则表现跟NSCalendar一样.
            lua_pushnil(L);
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - 元方法
static int __index(lua_State *L) {
    const char *className = luaL_checkstring(L, 2);
    NSLog(@"__index className = %s",className);
    
    if (kj_cannotAccessClass([NSString stringWithUTF8String:className])) {
        return 1;
    }
    
    Class _Class = objc_getClass(className);
    if (_Class) { // create userdata of _Class and push it onto stack.
//        mp_CreateUserdataIfNoCache(L, _Class, YES);
    } else {
        lua_pushnil(L);
    }
    return 1;
}
static int __call(lua_State *L) {
    NSLog(@"__call");
    return 1;
}

static int __test_func(lua_State *L) {
    NSLog(@"__test_func");
    return 1;
}

#pragma mark - C Meta Functions
static const struct luaL_Reg Metafunctions[] = {
    {"__index", __index},
    {"__call", __call},
    {"__test_func", __test_func},
    {NULL, NULL}
};
static const struct luaL_Reg Functions[] = {
    {NULL, NULL}
};


#pragma mark - kj_setUpClass

int kj_setUpClass(lua_State *l) {
    
    //创建元表 __OC_CLASS_MEETATABLE
    luaL_newmetatable(l, "__OC_CLASS_MEETATABLE");
    
    //注册元方法
    luaL_register(l, NULL, Metafunctions); // register metafunctions to metatable.
    
    //创建全局table, __OC_CLASS_TABLE
    luaL_register(l, "__OC_CLASS_TABLE", Functions);
    
    //将元表压栈
    luaL_getmetatable(l, "__OC_CLASS_MEETATABLE");

    //设置为index的元表，并pop stack
    lua_setmetatable(l, -2);
 
    //清理栈空间
    lua_settop(l, 0);
    
    return 1;
}
