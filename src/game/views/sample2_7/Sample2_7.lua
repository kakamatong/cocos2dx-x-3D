local Sample2_7 = class("Sample2_7", cc.load("mvc").ViewBase)
Sample2_7.RESOURCE_FILENAME = "Game/Sample2_7/Sample2_7.csb"
Sample2_7.LAYER_2D = "Game/Sample2_7/My2DLayer.csb"

Sample2_7.KK_BTN_CLOSE = "KK_BTN_CLOSE"

Sample2_7.KK_CAMERA = "KK_CAMERA"

function Sample2_7:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    end

    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
    end
end

function Sample2_7:onTouchEvent(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.ENDED then

    end

    if eventType ~= cc.EventCode.ENDED then
        return 
    end

    local name = ref:getName()
    local tag = ref:getTag()
    print(self.name_, "onTouchEvent", name, tag)
    if name == self.KK_BTN_CLOSE then
        self:onBtnClose()
    end
end

function Sample2_7:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return Sample2_7