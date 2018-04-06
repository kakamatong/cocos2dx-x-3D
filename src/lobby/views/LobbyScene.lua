
local LobbyScene = class("LobbyScene", cc.load("mvc").ViewBase)
LobbyScene.RESOURCE_FILENAME = "Lobby/LobbyScene.csb"

LobbyScene.KK_SAMPLE_2_1 = "KK_SAMPLE_2_1"
LobbyScene.KK_SAMPLE_2_2 = "KK_SAMPLE_2_2"

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
    if name == self.KK_SAMPLE_2_1 then
        self:onBtnSample_2_1()
    elseif name == self.KK_BILLBOARD then
        self:onBtnBillBoard()
    elseif name == self.KK_SAMPLE_2_2 then
        self:onBtnSample_2_2()
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

function LobbyScene:onBtnSample_2_1()
    local configs = {
        viewsRoot  = "game.views.sample2_1",
        modelsRoot = "game.models",
        defaultSceneName = "Sample2_1",
    }
    require("game.GameApp"):create(configs):run()
end

function LobbyScene:onBtnSample_2_2()
    local configs = {
        viewsRoot  = "game.views.sample2_2",
        modelsRoot = "game.models",
        defaultSceneName = "Sample2_2",
    }
    require("game.GameApp"):create(configs):run()
end

return LobbyScene
