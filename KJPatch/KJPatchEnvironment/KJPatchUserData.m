//
//  KJPatchUserData.m
//  KJPatch
//
//  Created by Jack on 2021/9/17.
//

#import "KJPatchUserData.h"
#import "KJPatchHeader.h"



static const struct luaL_Reg Metafunctions[] = {
//    {"__index", __index},
//    {"__newindex", __newindex},
//    {"__gc", __gc},
    {NULL, NULL}
};

static const struct luaL_Reg Functions[] = {
//    {"get", __kjGetIvar},
//    {"set", __kjSetIvar},
    {NULL, NULL}
};


/// 初始化userdata环境
int kj_setupUserdata(lua_State *L) {
    
    luaL_newmetatable(L, USERDATA_META_TABLE_NAME);
    luaL_register(L, NULL, Metafunctions);
    luaL_register(L, USERDATA_IVAR_TABLE_NAME, Functions);

//    kj_lua_newGlobalTableWithMetaFuncs(L, WEAK_USERDATA_TABLE_NAME, WeakTableMetaFunctions); // pseudo weak table
//    kj_lua_newGlobalTableWithMetaFuncs(L, VALID_USERDATA_TABLE_NAME, ValidateWeakMetaFunctions);

    return 1;
}

/// @param object maybe a Class or Instance of the OC.
KJPatchUserData* kj_createUserdataIfNoCache(lua_State *L, id object, BOOL isClass);
