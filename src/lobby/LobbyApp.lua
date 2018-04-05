
local LobbyApp = class("LobbyApp", cc.load("mvc").AppBase)

function LobbyApp:onCreate()
    math.randomseed(os.time())
end

return LobbyApp
