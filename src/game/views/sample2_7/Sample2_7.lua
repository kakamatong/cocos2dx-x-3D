local Sample2_7 = class("Sample2_7", cc.load("mvc").ViewBase)
Sample2_7.RESOURCE_FILENAME = "Game/Sample2_7/Sample2_7.csb"
Sample2_7.LAYER_2D = "Game/Sample2_7/My2DLayer.csb"

Sample2_7.KK_BTN_CLOSE = "KK_BTN_CLOSE"

Sample2_7.KK_CAMERA = "KK_CAMERA"
Sample2_7.KK_MENU = "KK_MENU"

Sample2_7.snooker = import(".SnookerBall")
Sample2_7.Constant = import(".Constant")

Sample2_7.lxs = 0
Sample2_7.lxst = 0
Sample2_7.lxm = 0
Sample2_7.tempvx = 0
Sample2_7.tempvz = 0
Sample2_7.startAngle = 0
Sample2_7.degree = 0

function Sample2_7:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_MENU, handler(self, self.onTouchMenu))

        local sche = cc.Director:getInstance():getScheduler()
        self.scheID = sche:scheduleScriptFunc(handler(self, self.updateFrame), 0, false)
    end

    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
    end

    local snooker0 = self.snooker:create(0)
    snooker0:setPosition3D(cc.vec3(-300,0,0))
    snooker0:setCameraMask(cc.CameraFlag.USER1)
    -- snooker0.vx = 600
    -- snooker0.vz = 0
    table.insert(self.Constant.snookerList, snooker0)
    self.resourceNode_:addChild(snooker0)
    self.ballWhite = snooker0

    local maxBoll = 6
    for i = 1, maxBoll do
        local j = 0
        local k = 0
        local l = i % 6 + 1
        while i > k do
            j = j + 1
            k = (1 + j) * j / 2
        end

        k = i % j
        local tmpSnooker = self.snooker:create(l)
        tmpSnooker:setGlobalZOrder(0.1 * i - 1)
        tmpSnooker:setPosition3D(cc.vec3(100 + 54 * j,0,-31 * (j - 1) + 62 * k))
        tmpSnooker:setCameraMask(cc.CameraFlag.USER1)
        table.insert(self.Constant.snookerList, tmpSnooker)
        self.resourceNode_:addChild(tmpSnooker)
    end
end

function Sample2_7:onTouchMenu(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        self.lxst = ref:getTouchBeganPosition().x
        self.lxs = self.lxst
    elseif eventType == cc.EventCode.ENDED then
        local endx = ref:getTouchEndPosition().x
        local endy = ref:getTouchEndPosition().y
        if math.abs(endx - self.lxst) < 5 then
            local size = cc.Director:getInstance():getWinSize()
            local dx = endx - size.width / 2
            local dy = endy - size.height / 2
            self.tempvx = 1000 * dx / size.width
            self.tempvz = 1000 * dy / size.height
        end
    elseif eventType == cc.EventCode.MOVED then
        self.lxm = ref:getTouchMovePosition().x
        if self.lxm - self.lxs < -5 then
            self.degree = self.degree + 4
            if self.degree >= 360 then
                self.degree = self.degree - 360 
            end

            local cx = math.sin(self.degree * math.pi / 180) * 600
            local cz = math.cos(self.degree * math.pi / 180) * 600

            local userCamera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
            if userCamera then
                userCamera:setPosition3D(cc.vec3(cx,600,cz)) 
                userCamera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
            end

        elseif self.lxm - self.lxs > 5 then
            self.degree = self.degree - 4
            if self.degree <= -360 then
                self.degree = self.degree + 360 
            end

            local cx = math.sin(self.degree * math.pi / 180) * 600
            local cz = math.cos(self.degree * math.pi / 180) * 600

            local userCamera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
            if userCamera then
                userCamera:setPosition3D(cc.vec3(cx,600,cz)) 
                userCamera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
            end
        end

        self.lxs = self.lxm

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

function Sample2_7:updateFrame()
    for k, v in pairs(self.Constant.snookerList) do
        v:go()
    end
    if self.tempvx ~= 0 then
        self.ballWhite.vx = self.tempvx
        self.tempvx = 0
    end

    if self.tempvz ~= 0 then
        self.ballWhite.vz = self.tempvz
        self.tempvz = 0
    end

end

function Sample2_7:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
        self.Constant.snookerList = {}
    end
end

return Sample2_7