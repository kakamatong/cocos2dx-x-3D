local Sample2_1 = class("Sample2_1", cc.load("mvc").ViewBase)
Sample2_1.RESOURCE_FILENAME = "Game/Sample2_1/Sample2_1.csb"
Sample2_1.LAYER_2D = "Game/Sample2_1/My2DLayer.csb"

Sample2_1.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample2_1.KK_MENU   = "KK_MENU"
Sample2_1.KK_CAMERA = "KK_CAMERA"
Sample2_1.degree = 0

function Sample2_1:onCreate()
    print("onCreate")

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_MENU, handler(self, self.onTouchMenu))
    end
end

function Sample2_1:onTouchMenu(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        self.beginPosX = ref:getTouchBeganPosition().x
        self.prePosX = self.beginPosX
    elseif eventType == cc.EventCode.END then

    elseif eventType == cc.EventCode.MOVED then
        local name = ref:getName()
        local tag = ref:getTag()
        
        local nowPosX = ref:getTouchMovePosition().x
        local isMove = false
        local dx = math.abs(nowPosX - self.beginPosX)
        print(nowPosX, self.beginPosX, dx)
        if dx > 8 then
            isMove = true
        end

        if isMove then
            self.degree = self.degree - 0.2 * (nowPosX - self.prePosX)
            if self.degree >= 360 then
                self.degree = self.degree - 360
            elseif self.degree <= 0 then
                self.degree = self.degree + 360
            end

            local cx = math.sin(self.degree * 3.1415926 / 180) * 600
            local cz = math.cos(self.degree * 3.1415926 / 180) * 600
            local userCamera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
            if userCamera then
                userCamera:setPosition3D(cc.vec3(cx,150,cz)) 
                userCamera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
            end
        end
        self.prePosX = nowPosX

    end
end

function Sample2_1:onTouchEvent(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.END then

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

function Sample2_1:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return Sample2_1