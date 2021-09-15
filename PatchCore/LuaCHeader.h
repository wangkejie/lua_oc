//
//  LuaCHeader.h
//  Lua_OC
//
//  Created by Jack on 2021/9/15.
//

#ifndef LuaCHeader_h
#define LuaCHeader_h

//#import <LuaC/LuaC.h>
//#import "mil_lua.h"
#import <LuaC/LuaC.h>


//快捷
lua_State *luaP_currentState(void);
void pc_printLuaStackPoints(lua_State *l);

void pc_setNewGlobalTableWithMetaFuncs(lua_State *L, const char *tableName, const luaL_Reg *metaFuncs);

#endif /* LuaCHeader_h */
