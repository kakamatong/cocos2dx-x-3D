local Constant = Constant or {}

Constant.SNOOKER_R = 30
Constant.ANGLE_SPAN = 11.25
Constant.TIME_SPAN = 0.05
Constant.V_TENUATION = 0.995
Constant.V_THRESHOLD = 1.0
Constant.TABLE_SIZE_X = 600
Constant.TABLE_SIZE_Z = 300
Constant.snookerList = {}

--看不懂
Constant.collisionCalculate = function (snooker1, snooker2)
    if snooker1 and snooker2 then
        local BAx = snooker1:getPositionX() - snooker2:getPositionX()
        local BAz = snooker1:getPositionZ() - snooker2:getPositionZ()
        local pos1 = snooker1:getPosition3D()
        local pos2 = snooker2:getPosition3D()
        local l = ToolUtils.pos3DLength(pos1,pos2)
        if l > 2 * Constant.SNOOKER_R then
            return false
        end

        --print("collisionCalculate", snooker1.index, snooker2.index)
        print("L:",l)
        local bVx = snooker2.vx * 0.8
        local bVz = snooker2.vz * 0.8
        local vB = math.sqrt(bVx * bVx + bVz * bVz)
        local vbCollx = 0
        local vbCollz = 0
        local vbVerticalX = 0
        local vbVerticalZ = 0
        if vB > Constant.V_THRESHOLD then
            local angle = cc.pGetAngle(cc.vec3(bVx,0,bVz),cc.vec3(BAx, 0, BAz))
            local vbColl = vB * math.cos(angle) 

            vbCollx = (vbColl / l) * BAx
            vbCollz = (vbColl / l) * BAz

            vbVerticalX = bVx - vbCollx
            vbVerticalZ = bVz - vbCollz
        end

        local aVx = snooker1.vx * 0.8
        local aVz = snooker1.vz * 0.8
        local vA = math.sqrt(aVx * aVx + aVz* aVz)
        local vaCollx = 0
        local vaCollz = 0
        local vaVerticalX = 0
        local vaVerticalZ = 0
        if Constant.V_THRESHOLD < vA then
            local angle = cc.pGetAngle(cc.vec3(aVx,0,aVz),cc.vec3(BAx, 0, BAz))
            local vaColl = vA * math.cos(angle) 
            --local vaColl = vA * math.cos(ToolUtils.posAngle(cc.vec3(aVx,0,aVz),cc.vec3(BAx, 0, BAz))) 
            vaCollx = (vaColl / l) * BAx
            vaCollz = (vaColl / l) * BAz

            vaVerticalX = aVx - vaCollx
            vaVerticalZ = aVz - vaCollz
        end

        snooker1.vx = vaVerticalX + vbCollx
        snooker1.vz = vaVerticalZ + vbCollz

        print("snooker1:", snooker1.vx, snooker1.vz)

        snooker2.vx = vbVerticalX + vaCollx
        snooker2.vz = vbVerticalZ + vaCollz

        print("snooker2:", snooker2.vx, snooker2.vz)

        return true
    end
end

return Constant