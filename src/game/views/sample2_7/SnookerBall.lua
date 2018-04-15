local SnookerBall = class("SnookerBall", cc.Node)

SnookerBall.snooker = nil
SnookerBall.ballShadow = nil
SnookerBall.vx = 0
SnookerBall.vz = 0

function SnookerBall:ctor(index)
    self.snooker = cc.Sprite3D:create("Game/Sample2_7/snooker/ball.obj", string.format("Game/Sample2_7/snooker/snooker%d.jpg",index))
    self.ballShadow = cc.Sprite3D:create("Game/Sample2_7/snooker/ballShadow.obj","Game/Sample2_7/snooker/ballShadow.obj")
    self:addChild(self.snooker)
    self:addChild(self.ballShadow)
    self.ballShadow:setPosition3D(cc.vec3(0,-29.9+index*0.01 + 0.13,0))
    self.ballShadow:setScale(0.8)
end

function SnookerBall:go()

end

return  SnookerBall


