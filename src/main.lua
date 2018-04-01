require("LuaDebug")("localhost", 7003)
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
require "utils.init"

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
