local Sample2_8 = class("Sample2_8", cc.load("mvc").ViewBase)
Sample2_8.RESOURCE_FILENAME = "Game/Sample2_8/Sample2_8.csb"
Sample2_8.LAYER_2D = "Game/Sample2_8/My2DLayer.csb"

Sample2_8.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample2_8.KK_BOSS = "KK_BOSS"
Sample2_8.KK_CAMERA = "KK_CAMERA"
Sample2_8.KK_BTN_3 = "KK_BTN_3"
Sample2_8.KK_BTN_1 = "KK_BTN_1"
Sample2_8.KK_BTN_2 = "KK_BTN_2"
Sample2_8.KK_BTN_4 = "KK_BTN_4"

function Sample2_8:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_3, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_1, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_2, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_4, handler(self, self.onTouchEvent))
    end

    self.camera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
    if self.camera then
        self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
        self.dDegree = 360 / (20 * 60)
        self.nowDegree = 0
        local sche = cc.Director:getInstance():getScheduler()
        self.scheID = sche:scheduleScriptFunc(handler(self, self.updateFrame), 0, false)
    end

    self.moveTo = cc.MoveTo:create(1,cc.vec3(30,30,30))
    self.moveBy = cc.MoveBy:create(1,cc.vec3(150,150,150))
    self.rotateTo = cc.RotateTo:create(1,cc.vec3(0,0,120))
    self.rotateBy = cc.RotateBy:create(1,cc.vec3(5,5,-90))
end

function Sample2_8:updateFrame()
    self.nowDegree = self.nowDegree + self.dDegree
    if self.nowDegree >= 360 then
        self.nowDegree = self.nowDegree - 360
    elseif self.nowDegree <= 0 then
        self.nowDegree = self.nowDegree + 360
    end
    --print("-----nowDegree", self.nowDegree)
    local cx = math.sin(self.nowDegree * 3.1415926 / 180) * 200
    local cz = math.cos(self.nowDegree * 3.1415926 / 180) * 200

    self.camera:setPosition3D(cc.vec3(cx,20,cz)) 
    self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
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
    elseif name == self.KK_BTN_1 or name == self.KK_BTN_2 or name == self.KK_BTN_3 or name == self.KK_BTN_4 then
        
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

function Sample2_8:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample2_8