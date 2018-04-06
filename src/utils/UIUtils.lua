local UIUtils = UIUtils or {}

function UIUtils.findNodeByName(fatherNode, childName)
    if fatherNode and childName then
        local nodeName = fatherNode:getName()
        if nodeName == childName then
            return fatherNode
        end

        local childs = fatherNode:getChildren()
        for k, v in pairs(childs) do
            local childNode = UIUtils.findNodeByName(v,childName)
            if childNode then
                return childNode
            end
        end

        return nil

    else
        print("UIUtils.findNodeByName ERROR", fatherNode, childName)
    end
end

function UIUtils.addTouchEventListener(fatherNode, childName, callBack)
    local childNode = UIUtils.findNodeByName(fatherNode,childName)
    if childNode then
        childNode:addTouchEventListener(callBack)
    else
        print("UIUtils.addTouchEventListener ERROR", fatherNode, childName)
    end
end

function UIUtils.addEventListener(fatherNode, childName, callBack)
    local childNode = UIUtils.findNodeByName(fatherNode,childName)
    if childNode then
        childNode:addEventListener(callBack)
    else
        print("UIUtils.addEventListener ERROR", fatherNode, childName)
    end
end

function UIUtils.setSelected(fatherNode, childName, b)
    local childNode = UIUtils.findNodeByName(fatherNode,childName)
    if childNode then
        childNode:setSelected(b)
    else
        print("UIUtils.setSelected ERROR", fatherNode, childName)
    end
end

function UIUtils.setString(fatherNode, childName, str)
    local childNode = UIUtils.findNodeByName(fatherNode,childName)
    if childNode then
        childNode:setString(str)
    else
        print("UIUtils.setString ERROR", fatherNode, childName)
    end
end

return UIUtils