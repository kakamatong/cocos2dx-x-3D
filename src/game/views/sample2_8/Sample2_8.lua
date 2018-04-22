local Sample2_8 = class("Sample2_8", cc.load("mvc").ViewBase)
Sample2_8.RESOURCE_FILENAME = "Game/Sample2_8/Sample2_8.csb"
Sample2_8.LAYER_2D = "Game/Sample2_8/My2DLayer.csb"

Sample2_8.KK_BTN_CLOSE = "KK_BTN_CLOSE"

function Sample2_8:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    end

    local userCamera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
    if userCamera then
        userCamera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
    end
end

function Sample2_8:onTouchEvent(ref, eventType)
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

function Sample2_8:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return Sample2_8