
local LobbyScene = class("LobbyScene", cc.load("mvc").ViewBase)
LobbyScene.RESOURCE_FILENAME = "Lobby/LobbyScene.csb"
--LobbyScene.RESOURCE_FILENAME = "Lobby/Sample2_1/Sample2_1.csb"
LobbyScene.NODE3D_CSBPATH = "Lobby/Sample2_1/Sample2_1.csb"
LobbyScene.KK_SAMPLE_2_1 = "KK_SAMPLE_2_1"

function LobbyScene:onCreate()
    local img = UIUtils.findNodeByName(self.resourceNode_, "Image_1")
    if img then
       print("can find Node") 
    end

    local txt = UIUtils.findNodeByName(self.resourceNode_,"Text_1")
    if txt then
        txt:setString("3D 测试demo")
    end
    --local tmpPath = rawget(self.class, "NODE3D_CSBPATH")
    local node3d = cc.CSLoader:createNodeWithVisibleSize(self.NODE3D_CSBPATH)
    if node3d then
        self:addChild(node3d) 
    end

    local sample_2_1 = UIUtils.findNodeByName(self.resourceNode_, self.KK_SAMPLE_2_1)
    if sample_2_1 then
        sample_2_1:addTouchEventListener(handler(self, self.onTouchEvent))
    end

end

function LobbyScene:onTouchEvent(ref, eventType)
    local a = 1
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.END then

    end
end

return LobbyScene
