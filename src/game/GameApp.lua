local GameApp = class("GameApp", cc.load("mvc").AppBase)

function GameApp:onCreate()
    math.randomseed(os.time())
end

return GameApp