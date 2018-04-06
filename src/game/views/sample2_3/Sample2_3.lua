local Sample2_3 = class("Sample2_3", cc.load("mvc").ViewBase)
--本示例场景资源都来自公告板
Sample2_3.RESOURCE_FILENAME = "Game/BillBoard/BillBoard.csb"
Sample2_3.LAYER_2D = "Game/BillBoard/My2DLayer.csb"
Sample2_3.KK_CAMERA = "KK_CAMERA"
Sample2_3.KK_BTN_CLOSE = "KK_BTN_CLOSE"
Sample2_3.KK_TITLE = "KK_TITLE"

function Sample2_3:onCreate()
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

    local billBoard = cc.BillBoard:create("Game/Public/Imge/Icon.png")
    if billBoard then
        billBoard:setPosition3D(cc.vec3(0,150,0))
        billBoard:setCameraMask(2)
        local txt = ccui.Text:create()
        txt:setString("BillBoard")
        txt:setCameraMask(2)
        billBoard:addChild(txt)

        self.resourceNode_:addChild(billBoard)
    end

    local imageView = ccui.ImageView:create("Game/Public/Imge/Icon.png", ccui.TextureResType.localType)
    if imageView then
        imageView:setPosition3D(cc.vec3(-100,150,0))
        imageView:setCameraMask(2)
        local txt = ccui.Text:create()
        txt:setString("imageView")
        txt:setCameraMask(2)
        imageView:addChild(txt)
        self.resourceNode_:addChild(imageView)
    end

    local userCamera = UIUtils.findNodeByName(self.resourceNode_,self.KK_CAMERA)
    if userCamera then
        local cameraBG = cc.CameraBackgroundColorBrush:create(cc.c4b(104,33,121,1),1)
        userCamera:setBackgroundBrush(cameraBG)
        userCamera:clearBackground()
    end

    UIUtils.setString(self.resourceNode_,self.KK_TITLE,"摄像机背景画笔演示")
end

function Sample2_3:updateFrame()
    self.nowDegree = self.nowDegree + self.dDegree
    if self.nowDegree >= 360 then
        self.nowDegree = self.nowDegree - 360
    end
    --print("-----nowDegree", self.nowDegree)
    local cx = math.sin(self.nowDegree * 3.1415926 / 180) * 600
    local cz = math.cos(self.nowDegree * 3.1415926 / 180) * 600

    self.camera:setPosition3D(cc.vec3(cx,150,cz)) 
    self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
end

function Sample2_3:onTouchEvent(ref, eventType)
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

function Sample2_3:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

function Sample2_3:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample2_3