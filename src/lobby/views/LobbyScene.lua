
local LobbyScene = class("LobbyScene", cc.load("mvc").ViewBase)
LobbyScene.RESOURCE_FILENAME = "Lobby/LobbyScene.csb"

LobbyScene.KK_SAMPLE_2_1 = "KK_SAMPLE_2_1"
LobbyScene.KK_SAMPLE_2_2 = "KK_SAMPLE_2_2"
LobbyScene.KK_SAMPLE_2_3 = "KK_SAMPLE_2_3"
LobbyScene.KK_SAMPLE_2_4 = "KK_SAMPLE_2_4"
LobbyScene.KK_SAMPLE_2_5 = "KK_SAMPLE_2_5"
LobbyScene.KK_SAMPLE_2_6 = "KK_SAMPLE_2_6"
LobbyScene.KK_SAMPLE_2_7 = "KK_SAMPLE_2_7"
LobbyScene.KK_SAMPLE_2_8 = "KK_SAMPLE_2_8"
LobbyScene.KK_SAMPLE_2_9 = "KK_SAMPLE_2_9"
LobbyScene.KK_SAMPLE = "KK_SAMPLE_"

LobbyScene.KK_BILLBOARD = "KK_BILLBOARD"

function LobbyScene:onCreate()
    local img = UIUtils.findNodeByName(self.resourceNode_, "Image_1")
    if img then
       print("can find Node") 
    end

    local txt = UIUtils.findNodeByName(self.resourceNode_,"Text_1")
    if txt then
        txt:setString("3D 测试demo")
    end

    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_1, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BILLBOARD, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_2, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_3, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_4, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_5, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_6, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_7, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_8, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_SAMPLE_2_9, handler(self, self.onTouchEvent))
end

function LobbyScene:onTouchEvent(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.ENDED then

    end

    if eventType ~= cc.EventCode.ENDED then
        return 
    end

    local name = ref:getName()
    local tag = ref:getTag()
    print(self.name_, "onTouchEvent", name, tag)
    if name == self.KK_BILLBOARD then
        self:onBtnBillBoard()
    elseif string.find(name,self.KK_SAMPLE) then
        local a = string.match(name,"KK_SAMPLE_(%d+)_")
        local b = string.match(name,"KK_SAMPLE_%d+_(%d+)")

        self:onBtnSample(tonumber(a), tonumber(b))
    end
end

function LobbyScene:onBtnBillBoard()
    local configs = {
        viewsRoot  = "game.views.billBoard",
        modelsRoot = "game.models",
        defaultSceneName = "BillBoard",
    }
    require("game.GameApp"):create(configs):run()
end

function LobbyScene:onBtnSample(a,b)
    local tmpViewRoomt = string.format("game.views.sample%d_%d", a, b)
    local tmpDefaultSceneName = string.format("Sample%d_%d", a, b)
    local configs = {
        viewsRoot  = tmpViewRoomt,
        modelsRoot = "game.models",
        defaultSceneName = tmpDefaultSceneName,
    }
    require("game.GameApp"):create(configs):run()
end

return LobbyScene
