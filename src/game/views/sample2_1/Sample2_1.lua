local Sample2_1 = class("Sample2_1", cc.load("mvc").ViewBase)
Sample2_1.RESOURCE_FILENAME = "Game/Sample2_1/Sample2_1.csb"

function Sample2_1:onCreate()
    print("onCreate")
end

function Sample2_1:onTouchEvent(ref, eventType)
    if eventType == cc.EventCode.BEGAN then
        
    elseif eventType == cc.EventCode.END then

    end
end

return Sample2_1