local PlaneWar = class("PlaneWar", cc.load("mvc").ViewBase)
PlaneWar.RESOURCE_FILENAME = "Game/PlaneWar/PlaneWar.csb"
PlaneWar.KK_BTN_CLOSE = "KK_BTN_CLOSE"
PlaneWar.KK_TOUCH_PNL = "KK_TOUCH_PNL"
PlaneWar.KK_PLANE = "KK_PLANE"
PlaneWar.touchb = 0
PlaneWar.planeWidth = 102
function PlaneWar:onCreate()
    print("onCreate")

    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_TOUCH_PNL, handler(self, self.onTouchPnl))
    self.plane = UIUtils.findNodeByName(self.resourceNode_, self.KK_PLANE)
end

function PlaneWar:onTouchEvent(ref, eventType)
    local name = ref:getName()
    local tag = ref:getTag()

    if eventType == cc.EventCode.BEGAN then
        print("%s onTouchBegin", name)
    elseif eventType == cc.EventCode.MOVED then
        print("%s onTouchMoved", name)
    elseif eventType == cc.EventCode.CANCELLED then
        print("%s onTouchCancelled", name)
    elseif eventType == cc.EventCode.ENDED then
        print("%s onTouchEnded", name)
    end

    if eventType ~= cc.EventCode.ENDED then
        return 
    end

    
    print(self.name_, "onTouchEvent", name, tag)
    if name == self.KK_BTN_CLOSE then
        self:onBtnClose()
    end
end

function PlaneWar:onTouchPnl(ref, eventType)
    local name = ref:getName()
    local tag = ref:getTag()
    if eventType == cc.EventCode.BEGAN then
        print("%s onTouchBegin", name)
        self.touchb = ref:getTouchBeganPosition().x
    elseif eventType == cc.EventCode.MOVED then
        print("%s onTouchMoved", name)
        self.touchm = ref:getTouchMovePosition().x
        self:onTouchPnlMove()
        self.touchb = self.touchm
    elseif eventType == cc.EventCode.CANCELLED then
        print("%s onTouchCancelled", name)
    elseif eventType == cc.EventCode.ENDED then
        print("%s onTouchEnded", name)
    end
end

function PlaneWar:onTouchPnlMove()
    local dx = self.touchm - self.touchb
    local planePrex = self.plane:getPositionX()
    self.plane:setPositionX(planePrex + dx)
end

function PlaneWar:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return PlaneWar