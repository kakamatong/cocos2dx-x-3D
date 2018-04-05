require("LuaDebug")("localhost", 7003)
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
require "utils.init"

local function main()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
