//
//  CrossTest.m
//  PatchCore
//
//  Created by Jack on 2021/9/15.
//

#import "CrossTest.h"
#import "LuaCHeader.h"

static lua_State *_luaP_currentState = nil;
lua_State *luaP_currentState() {
    if (!_luaP_currentState) {
        _luaP_currentState = lua_open();
    }
    return _luaP_currentState;
}
static int __index(lua_State *L) {
    NSLog(@"__index");
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


@implementation CrossTest

+ (void)start {
    NSLog(@"111111");
    lua_State * l = luaP_currentState();
    luaL_openlibs(l);
    
    [self setupClass];
}


+ (void)loadFileInPath:(NSString *)path {
    lua_State * l = luaP_currentState();
    luaL_dofile(l, path.UTF8String);
}



+ (void)setupClass {
    lua_State * l = luaP_currentState();
    
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
 
    //清理栈
    lua_settop(l, 0);
}

void pc_printLuaStackPoints(lua_State * L) {
    
    int top = lua_gettop(L);
    NSLog(@"当前栈顶为%d ============== ",top);
    for (int i = top; i > 0; i --) {
        const void * point = lua_topointer(L, i);
        NSLog(@"%p",point);
    }
    NSLog(@"当前lua栈，打印结束 ============== \n");
}


/// 设置全局的table
/// @param L lua_State
/// @param tableName table名字
/// @param metaFuncs 元方法
void pc_setNewGlobalTableWithMetaFuncs(lua_State *L, const char *tableName, const luaL_Reg *metaFuncs) {
    luaL_newmetatable(L, tableName);
    luaL_register(L, NULL, metaFuncs);
    lua_newtable(L);
    luaL_getmetatable(L, tableName);
    lua_setmetatable(L, -2);
    lua_setglobal(L, tableName);
}

/*

 ***
lua_pop(L,num)函数从栈顶开始移除。
当num>0时从栈顶移除指定个数 。
 当num=0时栈不受影响
当num=-1时栈中元素全部移除
***
 
 ***
 lua_settop函数说明
 该函数用于指定栈的高度，栈只能从栈顶压栈，不能从栈底添加数据。所以栈底的数据会保持不变。
 当新的高度大于原来的高度时，会从栈顶压入数据，压入的数据不可用(因为是随机的)。
 当新的高度小于原来的高度时，会从栈顶移除多余的元素。
 当输入参数为负数时，表示从栈顶开始的索引（最栈顶元素为-1）。该函数会移除栈顶到该元素之间的所以元素。-1则无，-2 则移除-1 。-3则移除-1，-2。以此类推。但是负数编号不能超出栈底的负数索引，超出会抛出异常。lua_pop函数及是使用了该特性。
 ***

 ***
 int luaL_getmetatable (lua_State *L,constchar*tname);
 将注册表中 tname 对应的元表（参见 luaL_newmetatable）压栈。如果没有 tname 对应的元表，则将 nil 压栈并返回假。
 ***
 
 
*/
@end
