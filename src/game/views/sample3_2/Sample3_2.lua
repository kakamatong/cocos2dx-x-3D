local Sample3_2 = class("Sample3_2", cc.load("mvc").ViewBase)
Sample3_2.RESOURCE_FILENAME = ""

function Sample3_2:onCreate()
    print("onCreate")
end

function Sample3_2:onTouchEvent(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.ENDED then

    end

    if eventType ~= cc.EventCode.ENDED then
        return 
    end

    local name = ref:getName()
    local tag = ref:getTag()
    print(self.name_, "onTouchEvent", name, tag)
end

return Sample3_2