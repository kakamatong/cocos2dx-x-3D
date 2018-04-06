local Sample2_2 = class("Sample2_2", cc.load("mvc").ViewBase)
Sample2_2.RESOURCE_FILENAME = "Game/Sample2_2/Sample2_2.csb"
Sample2_2.LAYER_2D = "Game/Sample2_2/My2DLayer.csb"

Sample2_2.KK_CAMERA = "KK_CAMERA"
Sample2_2.KK_BTN_CLOSE = "KK_BTN_CLOSE"

Sample2_2.KK_CHANGE_TYPE = "KK_CHANGE_TYPE"
Sample2_2.KK_CHTT   = "KK_CHTT"

Sample2_2.KK_CB_GL_BACK   = "KK_CB_GL_BACK"
Sample2_2.KK_CB_GL_FRONT   = "KK_CB_GL_FRONT"
Sample2_2.KK_CB_GL_BACK_AND_FRONT   = "KK_CB_GL_BACK_AND_FRONT"
Sample2_2.checkBoxList = {
    Sample2_2.KK_CB_GL_BACK,
    Sample2_2.KK_CB_GL_FRONT,
    Sample2_2.KK_CB_GL_BACK_AND_FRONT
}
function Sample2_2:onCreate()
    print("onCreate")
    self.camera = UIUtils.findNodeByName(self.resourceNode_, self.KK_CAMERA)
    if self.camera then
        self.dDegree = 360 / (20 * 60)
        self.nowDegree = 0
        local sche = cc.Director:getInstance():getScheduler()
        self.scheID = sche:scheduleScriptFunc(handler(self, self.updateFrame), 0, false)
    end

    self.chtt = UIUtils.findNodeByName(self.resourceNode_,self.KK_CHTT)
    if self.chtt then
        self.chtt:setCullFace(gl.BACK)
        self.chtt:setCullFaceEnabled(false)
    end

    local layer2d = cc.CSLoader:createNodeWithVisibleSize(self.LAYER_2D)
    if layer2d then
        self.resourceNode_:addChild(layer2d)
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
        UIUtils.addTouchEventListener(self.resourceNode_, self.KK_CHANGE_TYPE, handler(self,self.onTouchEvent))

        UIUtils.addEventListener(self.resourceNode_, self.KK_CB_GL_BACK, handler(self,self.onEventBack))
        UIUtils.addEventListener(self.resourceNode_, self.KK_CB_GL_FRONT, handler(self,self.onEventBack))
        UIUtils.addEventListener(self.resourceNode_, self.KK_CB_GL_BACK_AND_FRONT, handler(self,self.onEventBack))
    end

    self.openType = false
end

function Sample2_2:updateFrame()
    self.nowDegree = self.nowDegree + self.dDegree
    if self.nowDegree >= 360 then
        self.nowDegree = self.nowDegree - 360
    elseif self.nowDegree <= 0 then
        self.nowDegree = self.nowDegree + 360
    end
    --print("-----nowDegree", self.nowDegree)
    local cx = math.sin(self.nowDegree * 3.1415926 / 180) * 160
    local cz = math.cos(self.nowDegree * 3.1415926 / 180) * 160

    self.camera:setPosition3D(cc.vec3(cx,40,cz)) 
    self.camera:lookAt(cc.vec3(0,0,0), cc.vec3(0,1,0))
end

function Sample2_2:onEventBack(ref, eventType)
    if eventType == ccui.CheckBoxEventType.selected then
        self:onSelected(ref)
    elseif eventType == ccui.CheckBoxEventType.unselected then
        self:unSelected(ref)
    end
end

function Sample2_2:onSelected(ref)
    local name = ref:getName()
    for k, v in pairs(self.checkBoxList) do
        if v == name then
            self:changeTyep(name)
        else
            UIUtils.setSelected(self.resourceNode_,v,false)
        end
    end
end

function Sample2_2:unSelected(ref)
    local name = ref:getName()
    UIUtils.setSelected(self.resourceNode_,name,true)
end

function Sample2_2:changeTyep(name)
    if name == self.KK_CB_GL_BACK then
        self.chtt:setCullFace(gl.BACK)
    elseif name == self.KK_CB_GL_FRONT then
        self.chtt:setCullFace(gl.FRONT)
    elseif name == self.KK_CB_GL_BACK_AND_FRONT then
        self.chtt:setCullFace(gl.FRONT_AND_BACK)
    end
end

function Sample2_2:onTouchEvent(ref, eventType)
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
    elseif name == self.KK_CHANGE_TYPE then
        self:onBtnChangeType()
    end
end

function Sample2_2:onBtnChangeType()
    local titleText = ""
    if self.openType then
        self.openType = false
        titleText = "打开裁剪"
    else
        self.openType = true
        titleText = "关闭裁剪"
    end

    local button = UIUtils.findNodeByName(self.resourceNode_, self.KK_CHANGE_TYPE)
    if button then
        button:setTitleText(titleText)
    end

    if self.chtt then
        self.chtt:setCullFaceEnabled(self.openType)
    end
end

function Sample2_2:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

function Sample2_2:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
end

return Sample2_2