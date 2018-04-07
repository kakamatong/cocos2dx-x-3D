local Sample2_4 = class("Sample2_4", cc.load("mvc").ViewBase)
Sample2_4.RESOURCE_FILENAME = "Game/Sample2_4/Sample2_4.csb"
Sample2_4.LAYER_2D = "Game/Sample2_4/My2DLayer.csb"

Sample2_4.KK_CAMERA = "KK_CAMERA"
Sample2_4.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample2_4.KK_GUAISOU = "KK_GUAISOU"

function Sample2_4:onCreate()
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

    local wuqi = cc.Sprite3D:create("Game/Sample2_4/c3b/xiaoGuaiShou/weaponL.c3b")
    if wuqi then
        wuqi:setRotation3D(cc.vec3(0,60,0))
        wuqi:setScale(0.05)
        wuqi:setCameraMask(2)
        local guawu = UIUtils.findNodeByName(self.resourceNode_,self.KK_GUAISOU)
        if guawu then
            local node = guawu:getAttachNode("Bip01 L Finger0")
            node:addChild(wuqi)

            -- local act = cc.Animation3D:create("Game/Sample2_4/c3b/xiaoGuaiShou/xiaoGuaiShou.c3b")
            -- if act then
            --     local a = cc.Animate3D:create(act, 2, 5)
            --     a:setSpeed(a:getSpeed() * 0.7)
            --     guawu:runAction(cc.RepeatForever:create(a))
            -- end
        end
    end
end

function Sample2_4:updateFrame()
    self.nowDegree = self.nowDegree + self.dDegree
    if self.nowDegree >= 360 then
        self.nowDegree = self.nowDegree - 360
    elseif self.nowDegree <= 0 then
        self.nowDegree = self.nowDegree + 360
    end
    --print("-----nowDegree", self.nowDegree)
    local cx = math.sin(self.nowDegree * 3.1415926 / 180) * 420
    local cz = math.cos(self.nowDegree * 3.1415926 / 180) * 420

    self.camera:setPosition3D(cc.vec3(cx,150,cz)) 
    self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
end

function Sample2_4:onTouchEvent(ref, eventType)
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

function Sample2_4:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

function Sample2_4:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample2_4