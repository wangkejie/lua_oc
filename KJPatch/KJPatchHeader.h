//
//  KJPatchHeader.h
//  Lua_OC
//
//  Created by Jack on 2021/9/17.
//

#ifndef KJPatchHeader_h
#define KJPatchHeader_h

#define KJException(fmt, ...) KJ_ExceptionCatch([NSString stringWithFormat:@"⚠️KJ_PATCH_ERROR⚠️ " fmt, ##__VA_ARGS__]);


#pragma mark - lua的一些table或者元table
#define USERDATA_META_TABLE_NAME "KJPatchUserdataMetatableName"
#define USERDATA_IVAR_TABLE_NAME "ivar"
#define STRUCT_META_TABLE_NAME "KJPatchStructMetatableName"
#define BLOCK_META_TABLE_NAME "KJPatchBlockMetableName"
#define BLOCK_GLOBAL_TABLE_NAME "toBlock"
#define GCD_META_TABLE_NAME "KJPatchGCDMetatableName"


#define KJ_CSTRING_EQUAL(str1, str2) (strcmp((str1), (str2)) == 0)
#define KJ_CNSTRING_EQUAL(str1, str2, num) (strncmp((str1), (str2), num) == 0)

#endif /* KJPatchHeader_h */
