local PlaneWar = class("PlaneWar", cc.load("mvc").ViewBase)
PlaneWar.RESOURCE_FILENAME = "Game/PlaneWar/PlaneWar.csb"
PlaneWar.KK_BTN_CLOSE = "KK_BTN_CLOSE"
PlaneWar.KK_TOUCH_PNL = "KK_TOUCH_PNL"
PlaneWar.KK_PLANE = "KK_PLANE"
PlaneWar.touchb = 0
PlaneWar.planeWidth = 102
PlaneWar.planeHeight = 126
PlaneWar.bulletLaunchTime = 0.15
PlaneWar.bulletInfo = {
    time = 2,
    range = 1000
}
PlaneWar.bullets = {}

PlaneWar.enemyCreateTime = 1
PlaneWar.enemyWidth = 169
PlaneWar.enemyHeight = 258
PlaneWar.enemyInfo = {
    time = 2,
    range = -1200
}
PlaneWar.enemys = {}
function PlaneWar:onCreate()
    print("onCreate")
    self.bullets = {}
    self.enemys = {}
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_BTN_CLOSE, handler(self, self.onTouchEvent))
    UIUtils.addTouchEventListener(self.resourceNode_, self.KK_TOUCH_PNL, handler(self, self.onTouchPnl))
    self.plane = UIUtils.findNodeByName(self.resourceNode_, self.KK_PLANE)
    self:startBullet()
    self:startEnemy()
    self:startHitTest()
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
    self:planeMove(dx)
end

function PlaneWar:checkBoundary(x)
    local winSize = cc.Director:getInstance():getWinSize()
    local minX = self.planeWidth / 2
    local maxX = winSize.width - self.planeWidth / 2
    if x < minX or x > maxX then
        return false
    else
        return true
    end
end

function PlaneWar:planeMove(dx)
    local planePrex = self.plane:getPositionX()
    local nowx = planePrex + dx
    if self:checkBoundary(nowx) then
        self.plane:setPositionX(nowx)
    end
end

function PlaneWar:startBullet()
    local sche = cc.Director:getInstance():getScheduler()
    self.scheID = sche:scheduleScriptFunc(handler(self, self.createBulletAndMove), self.bulletLaunchTime, false)
end

function PlaneWar:createBulletAndMove()
    local bullet = ccui.ImageView:create("Game/PlaneWar/imge/bullet1.png",ccui.TextureResType.plistType)
    local x,y = self.plane:getPosition()
    bullet:setPosition(cc.p(x, y + self.planeHeight / 2))
    self:addBullet(bullet)
    local moveBy = cc.MoveBy:create(self.bulletInfo.time, cc.p(0,self.bulletInfo.range))
    local callBack = cc.CallFunc:create(
        function()
            self:removeBullet(bullet)
        end
    )
    local seq = cc.Sequence:create(moveBy, callBack)
    bullet:runAction(seq)
end

function PlaneWar:addBullet(node)
    table.insert(self.bullets, node)
    self.resourceNode_:addChild(node)
end

function PlaneWar:removeBullet(node)
    for k, v in pairs(self.bullets) do
        if v == node then
            self.bullets[k] = nil
            node:removeFromParent()
            break
        end
    end
end

function PlaneWar:startEnemy()
    local sche = cc.Director:getInstance():getScheduler()
    self.scheID1 = sche:scheduleScriptFunc(handler(self, self.createEnemyAndMove), self.enemyCreateTime, false)
end

function PlaneWar:createEnemyAndMove()
    local enemy = ccui.ImageView:create("Game/PlaneWar/imge/enemy3_n1.png",ccui.TextureResType.plistType)
    local winSize = cc.Director:getInstance():getWinSize()
    local minx = self.enemyWidth / 2
    local maxx = winSize.width - self.enemyWidth / 2
    local x = math.random(minx, maxx)
    local y = winSize.height + self.enemyHeight / 2
    enemy:setPosition(cc.p(x, y + self.planeHeight / 2))
    self:addEnemy(enemy)
    local moveBy = cc.MoveBy:create(self.enemyInfo.time, cc.p(0,self.enemyInfo.range))
    local callBack = cc.CallFunc:create(
        function()
            self:removeEnemy(enemy)
        end
    )
    local seq = cc.Sequence:create(moveBy, callBack)
    enemy:runAction(seq)
end

function PlaneWar:addEnemy(node)
    table.insert(self.enemys, node)
    self.resourceNode_:addChild(node)
end

function PlaneWar:removeEnemy(node)
    for k, v in pairs(self.enemys) do
        if v == node then
            self.enemys[k] = nil
            node:removeFromParent()
            break
        end
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

function PlaneWar:startHitTest()
    local sche = cc.Director:getInstance():getScheduler()
    self.scheID2 = sche:scheduleScriptFunc(handler(self, self.checkHitTest), 0, false)
end

function PlaneWar:checkHitTest()
    for i, j in pairs(self.bullets) do
        local x,y = j:getPosition()
        for k, v in pairs(self.enemys) do
            if self:hitTest(j,v) then
                self:removeBullet(j)
                self:removeEnemy(v)
                break
            end
        end
    end
end

function PlaneWar:hitTest(node1,node2)
    local rect1 = self:getRect(node1)
    local rect2 = self:getRect(node2)
    return cc.rectIntersectsRect(rect1, rect2)
end

function PlaneWar:getRect(node)
    local x,y = node:getPosition()
    local size = node:getContentSize()
    return cc.rect(x - size.width / 2,y - size.height / 2, size.width, size.height)
end

function PlaneWar:onExit()
    if self.scheID then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID)
    end
    if self.scheID1 then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID1)
    end
    if self.scheID2 then
        local sche = cc.Director:getInstance():getScheduler()
        sche:unscheduleScriptEntry(self.scheID2)
    end
end

return PlaneWar