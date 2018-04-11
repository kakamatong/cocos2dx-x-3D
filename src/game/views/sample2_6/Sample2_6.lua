local Sample2_6 = class("Sample2_6", cc.load("mvc").ViewBase)
Sample2_6.RESOURCE_FILENAME = "Game/Sample2_6/Sample2_6.csb"
Sample2_6.LAYER_2D = "Game/Sample2_6/My2DLayer.csb"
Sample2_6.LAYER_LOADING = "Game/Sample2_6/LoadLayer.csb"

Sample2_6.KK_BTN_CLOSE = "KK_BTN_CLOSE"

Sample2_6.KK_LOADING_INFO = "KK_LOADING_INFO"
Sample2_6.KK_LOADING_BAR = "KK_LOADING_BAR"
Sample2_6.KK_CAMERA = "KK_CAMERA"
Sample2_6.path = "Game/Sample2_6/c3b/"
Sample2_6.csbPath = {
    "floor/floor.c3b",
    "guanmu/guanMu.c3t",
    "hero1/Hi1.c3b",
    "hero2/Hi2.c3b",
    "hero3/Hi3.c3b",
    "hero4/Hi4.c3b",
    "tao/Tao.c3b",
}

function Sample2_6:onCreate()
    print("onCreate")
    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    end

    local loadingLayer = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_LOADING)
    if loadingLayer then
        self.resourceNode_:addChild(loadingLayer)
    end
    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
    end
    local allN = 7
    local n = 0
    
    
    for k, v in pairs(self.csbPath) do
        local func =function(sp3d,b)
            if loadingLayer then
                n = n + 1
                local p = (n / allN)*100
                local strP = string.format( "%.2f%%", p)
                UIUtils.setString(loadingLayer,self.KK_LOADING_INFO,strP)
                UIUtils.setPercent(loadingLayer,self.KK_LOADING_BAR,p)
                if n == allN then
                    loadingLayer:removeFromParent()
                end
            end
            if string.find(v,"floor") then
                sp3d:setScale(3)
                sp3d:setRotation3D(cc.vec3(-90,0,0))
                sp3d:setPosition3D(cc.vec3(0,0,0))
                sp3d:setCameraMask(2)
            elseif string.find(v, "Hi1") then
                sp3d:setScale(1.3)
                sp3d:setPosition3D(cc.vec3(-120,0,200))
                sp3d:setRotation3D(cc.vec3(0,90,0))
                sp3d:setCameraMask(2)
            elseif string.find(v, "Hi2") then
                sp3d:setScale(1.3)
                sp3d:setPosition3D(cc.vec3(120,0,200))
                sp3d:setRotation3D(cc.vec3(0,-90,0))
                sp3d:setCameraMask(2)
            elseif string.find(v, "Hi3") then
                sp3d:setScale(1.3)
                sp3d:setPosition3D(cc.vec3(-120,0,-200))
                sp3d:setRotation3D(cc.vec3(0,180,0))
                sp3d:setCameraMask(2)
            elseif string.find(v, "Hi4") then
                sp3d:setScale(1.3)
                sp3d:setPosition3D(cc.vec3(120,0,-200))
                sp3d:setCameraMask(2)
            elseif string.find(v, "Tao") then
                sp3d:setScale(0.8)
                sp3d:setPosition3D(cc.vec3(-200,0,0))
                sp3d:setRotation3D(cc.vec3(0,180,0))
                sp3d:setCameraMask(2)
            elseif string.find(v, "guanMu") then
                sp3d:setScale(0.8)
                sp3d:setPosition3D(cc.vec3(200,0,-100))
                sp3d:setRotation3D(cc.vec3(180,180,0))
                sp3d:setCameraMask(2)
            end
            
            self.resourceNode_:addChild(sp3d)
        end
        local fullPath = self.path .. v
        cc.Sprite3D:createAsync(fullPath,func)
    end
end

function Sample2_6:onTouchEvent(ref, eventType)
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

function Sample2_6:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return Sample2_6