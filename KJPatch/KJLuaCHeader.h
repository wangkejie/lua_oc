//
//  KJLuaCHeader.h
//  Lua_OC
//
//  Created by Jack on 2021/9/17.
//

#ifndef KJLuaCHeader_h
#define KJLuaCHeader_h

#import <LuaC/LuaC.h>

#pragma mark - lua的一些方法，在KJPatchExtension里找实现
//快捷
lua_State *kj_currentLuaState(void);
/// New a table with global name and meta functions.  创建全局的表table和包含的元方法
void kj_lua_newGlobalTableWithMetaFuncs(lua_State *L, const char *tableName, const luaL_Reg *metaFuncs);

#endif /* KJLuaCHeader_h */
