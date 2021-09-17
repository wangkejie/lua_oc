//
//  KJPatchExtension.m
//  KJPatch
//
//  Created by Jack on 2021/9/17.
//

#import "KJPatchExtension.h"
#import "KJLuaCHeader.h"

//全局lua虚拟机
static lua_State * _kj_currentState = nil;

lua_State *kj_currentLuaState(void) {
    if (!_kj_currentState) {
        _kj_currentState = lua_open();
    }
    return _kj_currentState;
}

/// 设置全局的table
/// @param L lua_State
/// @param tableName table名字
/// @param metaFuncs 元方法
void kj_lua_newGlobalTableWithMetaFuncs(lua_State *L, const char *tableName, const luaL_Reg *metaFuncs) {
    luaL_newmetatable(L, tableName);
    luaL_register(L, NULL, metaFuncs);
    lua_newtable(L);
    luaL_getmetatable(L, tableName);
    lua_setmetatable(L, -2);
    lua_setglobal(L, tableName);
}
