local Sample3_1 = class("Sample3_1", cc.load("mvc").ViewBase)
Sample3_1.RESOURCE_FILENAME = "Game/Sample3_1/Sample3_1.csb"
Sample3_1.LAYER_2D = "Game/Sample3_1/My2DLayer.csb"

Sample3_1.KK_CAMERA = "KK_CAMERA"
Sample3_1.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample3_1.KK_BTN_ADD    = "KK_BTN_ADD"
Sample3_1.KK_CH     = "KK_CH"

function Sample3_1:onCreate()
    print("onCreate")
    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.dDegree = 360 / (20 * 60)
        self.nowDegree = 0
        local sche = cc.Director:getInstance():getScheduler()
        self.scheID = sche:scheduleScriptFunc(handler(self, self.updateFrame), 0, false)
    end

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    end

    local maxTree = 6
    for i = 1, maxTree do
        local tree = cc.BillBoard:create("Game/Sample3_1/image/tree.png",cc.BillBoard_Mode.VIEW_PLANE_ORIENTED)
        local tmpx = math.random(-300, 300)
        local tmpz = math.random(-300, 300)
        if tree then
            tree:setPosition3D(cc.vec3(tmpx, 60, tmpz)) 
            tree:setCameraMask(cc.CameraFlag.USER1)
            tree:setScale(0.7)
        end
        
        self.resourceNode_:addChild(tree)
    end
end

function Sample3_1:updateFrame()
    self.nowDegree = self.nowDegree + self.dDegree
    if self.nowDegree >= 360 then
        self.nowDegree = self.nowDegree - 360
    elseif self.nowDegree <= 0 then
        self.nowDegree = self.nowDegree + 360
    end
    --print("-----nowDegree", self.nowDegree)
    local cx = math.sin(self.nowDegree * 3.1415926 / 180) * 600
    local cz = math.cos(self.nowDegree * 3.1415926 / 180) * 600

    self.camera:setPosition3D(cc.vec3(cx,100,cz)) 
    self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
end

function Sample3_1:onTouchEvent(ref, eventType)
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

function Sample3_1:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

function Sample3_1:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample3_1