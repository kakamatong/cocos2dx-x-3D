local PlaneWar = class("PlaneWar", cc.load("mvc").ViewBase)
PlaneWar.RESOURCE_FILENAME = "Game/PlaneWar/PlaneWar.csb"
PlaneWar.KK_BTN_CLOSE = "KK_BTN_CLOSE"

function PlaneWar:onCreate()
    print("onCreate")

    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
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

function PlaneWar:onBtnClose()
    local configs = {
        viewsRoot  = "lobby.views",
        modelsRoot = "lobby.models",
        defaultSceneName = "LobbyScene",
    }
    require("lobby.LobbyApp"):create(configs):run()
end

return PlaneWar