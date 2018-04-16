local SnookerBall = class("SnookerBall", cc.Node)

SnookerBall.snooker = nil
SnookerBall.ballShadow = nil
SnookerBall.vx = 0
SnookerBall.vz = 0
SnookerBall.Constant = import(".Constant")
SnookerBall.index = 0

function SnookerBall:ctor(index)
    self.index = index
    self.snooker = cc.Sprite3D:create("Game/Sample2_7/snooker/ball.obj", string.format("Game/Sample2_7/snooker/snooker%d.jpg",index))
    self.ballShadow = cc.Sprite3D:create("Game/Sample2_7/snooker/ballShadow.obj","Game/Sample2_7/snooker/ballShadow.png")
    self:addChild(self.snooker)
    self:addChild(self.ballShadow)
    self.ballShadow:setPosition3D(cc.vec3(0,-29.9+index*0.01 + 0.13,0))
    self.ballShadow:setScale(0.8)
end

function SnookerBall:go()
    local vTotal = math.sqrt( self.vx * self.vx + self.vz * self.vz )
    if vTotal == 0 then
        return 
    end

    local xOffset = self:getPositionX()
    local zOffset = self:getPositionZ()

    local tempX = xOffset
    local tempZ = zOffset

    xOffset = xOffset + self.vx * self.Constant.TIME_SPAN
    zOffset = zOffset + self.vz * self.Constant.TIME_SPAN

    self:setPositionX(xOffset)
    self:setPositionZ(zOffset)

    local flag = false

    for k, v in pairs(self.Constant.snookerList) do
        if v ~= self then
            if self.Constant.collisionCalculate(self, v) then
                flag = true
            end
        end
    end

    if xOffset < -self.Constant.TABLE_SIZE_X + self.Constant.SNOOKER_R or xOffset > self.Constant.TABLE_SIZE_X - self.Constant.SNOOKER_R then
        self.vx = -self.vx
        flag = true
    elseif zOffset < -self.Constant.TABLE_SIZE_Z + self.Constant.SNOOKER_R or zOffset > self.Constant.TABLE_SIZE_Z - self.Constant.SNOOKER_R then
        self.vz = -self.vz
        flag = true
    end

    if flag == false then
        local distance = vTotal * self.Constant.TIME_SPAN
        local axisXTemp = self.vz
        local axisYTemp = 0
        local axisZTemp = -self.vx

        local tmpAxis = cc.vec3(axisXTemp,axisYTemp,axisZTemp)

        local tmpAngrad = distance / self.Constant.SNOOKER_R

        local tmpQuaternion = cc.quaternion_createFromAxisAngle(tmpAxis,tmpAngrad)

        local myQuaternion = self.snooker:getRotationQuat()
    end


end

return  SnookerBall


