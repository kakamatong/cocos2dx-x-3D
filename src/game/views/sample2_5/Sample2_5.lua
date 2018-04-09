local Sample2_5 = class("Sample2_5", cc.load("mvc").ViewBase)
Sample2_5.RESOURCE_FILENAME = "Game/Sample2_4/Sample2_4.csb"
Sample2_5.LAYER_2D = "Game/Sample2_4/My2DLayer.csb"

Sample2_5.KK_CAMERA = "KK_CAMERA"
Sample2_5.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample2_5.KK_GUAISOU = "KK_GUAISOU"
Sample2_5.KK_TITLE = "KK_TITLE"
Sample2_5.KK_KING_NIGHT = "KK_KING_NIGHT"

function Sample2_5:onCreate()
    print("onCreate")
    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.dDegree = 360 / (20 * 60)
        self.nowDegree = 0
        --local sche = cc.Director:getInstance():getScheduler()
        --self.scheID = sche:scheduleScriptFunc(handler(self, self.updateFrame), 0, false)
    end

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
        UIUtils.setString(self.resourceNode_,self.KK_TITLE,"3D骨骼动画帧回调演示")
        local infos = ccui.Text:create()
        infos:setName("kk_infos")
        infos:setFontSize(35)
        infos:setPosition(cc.p(640,300))
        layer2d:addChild(infos)
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

            local act = cc.Animation3D:create("Game/Sample2_4/c3b/xiaoGuaiShou/xiaoGuaiShou.c3b")
            if act then
                local a = cc.Animate3D:create(act, 2, 5)
                a:setSpeed(a:getSpeed() * 0.7)
                guawu:runAction(cc.RepeatForever:create(a))
            end
        end
    end

    local kingNight = UIUtils.findNodeByName(self.resourceNode_,self.KK_KING_NIGHT)
    if kingNight then
        kingNight:stopAllActions()
        local animation3D = cc.Animation3D:create("Game/Sample2_4/c3b/knight/knight.c3b")
        if animation3D then
            local animate3D = cc.Animate3D:create(animation3D,2,5)
            animate3D:setSpeed(animate3D:getSpeed() * 0.7)
            kingNight:runAction(cc.RepeatForever:create(animate3D))
            --animate3D:setKeyFrameUserInfo(1,{})
            animate3D:setKeyFrameUserInfo(95,{})
            --local listener = cc.EventListenerCustom:new()
            local callBack = function(eventData,a,b)
                print("--------------------------aaaaaaaaa",type(eventData))
                local infos = UIUtils.findNodeByName(self.resourceNode_,"kk_infos")
                if infos then
                    infos:setString("冲啊！")
                end
                print(ToolUtils.serialize(eventData:getEventName()))
                local a = 1
            end
            local listener = cc.EventListenerCustom:create("CCAnimate3DDisplayedNotification",callBack)
            self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
        end
    end
end

function Sample2_5:updateFrame()
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

function Sample2_5:onTouchEvent(ref, eventType)
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

function Sample2_5:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

function Sample2_5:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample2_5