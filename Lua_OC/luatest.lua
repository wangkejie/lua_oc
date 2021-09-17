

setmetatable(_G, {
             __index = function(G, key)
                            print(key)
                            print("---------")
                            local userdata = __OC_CLASS_TABLE[key]
                            print(userdata)
                            print("-----")
                            if userdata then
                                print("找到了")
                                G[key] = userdata -- cache in _G
                            end
             
                            if not userdata then
                               --print("_G table not found and isn't a class, key is", key)
                            end
             
                            return userdata
                       end
})


print("222222222222")
dddddd()
print(__OC_CLASS_TABLE)
print(__OC_CLASS_MEETATABLE)
print(__OC_CLASS_MEETATABLE)
print(SSSS)

