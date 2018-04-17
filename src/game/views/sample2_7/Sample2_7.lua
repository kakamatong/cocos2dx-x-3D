local Sample2_7 = class("Sample2_7", cc.load("mvc").ViewBase)
Sample2_7.RESOURCE_FILENAME = "Game/Sample2_7/Sample2_7.csb"
Sample2_7.LAYER_2D = "Game/Sample2_7/My2DLayer.csb"

Sample2_7.KK_BTN_CLOSE = "KK_BTN_CLOSE"

Sample2_7.KK_CAMERA = "KK_CAMERA"

Sample2_7.snooker = import(".SnookerBall")
Sample2_7.Constant = import(".Constant")

function Sample2_7:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))

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
    snooker0.vx = 600
    snooker0.vz = 0
    table.insert(self.Constant.snookerList, snooker0)
    self.resourceNode_:addChild(snooker0)

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
end

function Sample2_7:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
        self.Constant.snookerList = {}
    end
end

return Sample2_7