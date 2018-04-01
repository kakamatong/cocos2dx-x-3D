
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
MainScene.RESOURCE_FILENAME = "Lobby/MainScene.csb"

function MainScene:onCreate()
    -- add background image
    -- display.newSprite("HelloWorld.png")
    --     :move(display.center)
    --     :addTo(self)

    -- -- add HelloWorld label
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx, display.cy + 200)
    --     :addTo(self)

    local img = UIUtils.findNodeByName(self.resourceNode_, "Image_1")
    if img then
       print("can find Node") 
    end

    local txt = UIUtils.findNodeByName(self.resourceNode_,"Text_1")
    if txt then
        txt:setString("3D 测试demo")
    end
end

return MainScene
