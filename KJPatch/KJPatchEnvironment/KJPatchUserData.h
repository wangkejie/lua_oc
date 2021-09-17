//
//  KJPatchUserData.h
//  KJPatch
//
//  Created by Jack on 2021/9/17.
//

#import <Foundation/Foundation.h>
#import "KJLuaCHeader.h"

/**
 lua和oc交互的，userdata类
 */

typedef struct KJPatchUserData {
    __unsafe_unretained id isa; ///< should be a Class or instance of OC.
    BOOL isClass;               ///< mark the `isa` is a class object whether or not.
    BOOL isPatchClass;          ///< whether a class that we want to fix.
    BOOL isWeak;                ///< whether save in weak table
} KJPatchUserData;


/// 初始化userdata环境
int kj_setupUserdata(lua_State *L);

/// @param object maybe a Class or Instance of the OC.
KJPatchUserData* kj_createUserdataIfNoCache(lua_State *L, id object, BOOL isClass);
