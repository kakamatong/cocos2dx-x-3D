local UIUtils = UIUtils or {}

function UIUtils.findNodeByName(node, childName)
    if node and childName then
        local nodeName = node:getName()
        if nodeName == childName then
            return node
        end

        local childs = node:getChildren()
        for k, v in pairs(childs) do
            local childNode = UIUtils.findNodeByName(v,childName)
            if childNode then
                return childNode
            end
        end

        return nil
    end

end

return UIUtils