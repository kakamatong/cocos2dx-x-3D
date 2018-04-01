
local ToolUtils = ToolUtils or {}

--[[
--字符串分割
--@param strInput     输入的字符串
--@param strDelimiter 用于分割的字符
--@return #table/如果分隔符为空,则返回空table
]]
function ToolUtils.split(strInput, strDelimiter)
    strInput = tostring(strInput)
    strDelimiter = tostring(strDelimiter)
    if (strDelimiter == '') then 
        return false 
    end
    local nPos, arr = 0, {}
    -- for each divider found
    for st, sp in function() return string.find(strInput, strDelimiter, nPos, true) end do
        table.insert(arr, string.sub(strInput, nPos, st - 1))
        nPos = sp + 1
    end
    table.insert(arr, string.sub(strInput, nPos))
    return arr
end

--[[
--字符串中是否全部是数字
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isDigit(str)
    if (string.find(str, "%D") == nil) then
        return true
    else
        return false
    end 
end

--[[
--字符串中是否全部是字母
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isAlpha(str)
    if (string.find(str,"%A") == nil) then
        return true
    else
        return false
    end 
end

--[[
--字符串中是否全部是数字或字母
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isAlNum(str)
    if (string.find(str, "%W") == nil) then
        return true
    else
        return false
    end 
end

--[[
--字符串中是否全部是小写字母
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isLower(str)
    if (string.find(str,"%L") == nil) then
        return true
    else
        return false
    end
end

--[[
--字符串中是否全部是大写字母
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isUpper(str)
    if (string.find(str, "%U") == nil) then
        return true
    else
        return false
    end 
end 

--[[
--字符串中是否全部是中文
--@param str 需要判断的字符串
--@return bool
]]
function ToolUtils.isChinese(str)
    if (string.find(str,"[\1-\127]+") == nil) then
        return true
    else
        return false
    end 
end

--[[
--将md5值持久化保存本地
--@param lpszKey  保存本地使用的关键字
--@param lpszData 传入的md5字符串
]]
function ToolUtils.saveStreamData(lpszKey,lpszData)
    local tmp_tab = {}  
    for i=1, string.len(lpszData) do 
        tmp_tab[i] = string.format("%02x", string.byte(lpszData,i))
    end
    local srcData = table.concat(tmp_tab)   
    cc.UserDefault:getInstance():setStringForKey(lpszKey,srcData)
end

--[[
--读取本地的持久化md5值
--@param  lpszKey  保存本地使用的关键字
--@return 一个md5字符串
]]
function ToolUtils.loadStreamData(lpszKey)
    local strData = cc.UserDefault:getInstance():getStringForKey(lpszKey, "null")
    if strData == "null" then return "" end       
    local lpszData = {}
    if strData == nil or "null" == strData then
        print("not found data by "..lpszKey)
        return lpszData
    end
    local i=1
    while true do
        if i >= #strData then
            break
        end         
        local hexValue = "0x"..string.sub(strData,i,i+1)
        local value = tonumber(hexValue,10)
        lpszData[#lpszData+1] = string.char(value)      
        i=i+2
    end 
    return table.concat(lpszData)
end

--[[
--将数字转为百分比字符串
--@param number 要转化的数字
--@param retain 要保留的小数位数
]]
function ToolUtils.getPercentString(number, retain)
    local ret = tostring(retain)
    return string.format("%."..ret.."f".."%%",number*100)
end

--[[
@brief 序列化字符串
]]--
function ToolUtils.serialize(obj)  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{"  
        for k, v in pairs(obj) do  
            lua = lua .. "[" .. ToolUtils.serialize(k) .. "]=" .. ToolUtils.serialize(v) .. ","  
        end  
        local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
            for k, v in pairs(metatable.__index) do  
                lua = lua .. "[" .. ToolUtils.serialize(k) .. "]=" .. ToolUtils.serialize(v) .. ","  
            end  
        end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    elseif t == "function"  then
        return "function"
    else
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua  
end  

--[[
@brief 反序列化字符串
]]--
function ToolUtils.unserialize(lua)  
    local t = type(lua)  
    if t == "nil" or lua == "" then  
        return nil  
    elseif t == "number" or t == "string" or t == "boolean" then  
        lua = tostring(lua)  
    else  
        error("can not unserialize a " .. t .. " type.")  
    end  
    lua = "return " .. lua  
    local func = loadstring(lua)  
    if func == nil then  
        return nil  
    end  
    return func()  
end

--[[
@brief 获取Lua串中int值
]]--
function ToolUtils.getLuaIntValue(luaString,variable)
    local value = 0
    local vs = {}
    vs = ToolUtils.split(luaString, ";")
    for i = 1,table.nums(vs) do
        local vss = {}
        vss = ToolUtils.split(vs[i], "=")
        if (table.nums(vss) >= 2 and vss[1] == variable)then
            value = tonumber(vss[2])
            return value
        end
    end
    return value
end

--[[
@brief 获取Lua串中Str值
]]--
function ToolUtils.getLuaStrValue(luaString,  variable)
    local value = ""
    local vs = {}
    vs = ToolUtils.split(luaString, ";")
    for i = 1,table.nums(vs) do
        local vss = {}
        vss = ToolUtils.split(vs[i], "=")
        if (table.nums(vss) >= 2 and vss[1] == variable)then
            value = vss[2]
            if (string.len(value) >= 2)then
                if (value[1] == '\'' and value[string.len(value)] == '\'')then
                    value = string.sub(value,1,string.len(value) - 1)
                end
            end
            return value
        end
    end

    return value
end



--[[
@brief 数字转化
]]--
function ToolUtils.numConversion(num)
    local numType = type(num)
    if numType ~= "string" and numType ~= "number" then
        return num
    end
    if "number" == numType then
        num = tostring(num)
    end
    
    local strNum = ""
    local length = #num
    
    if length > 4 and length <= 8 then
        local result = tonumber(num) / 10000
        if #tostring(math.ceil(result))==1 then
            strNum = string.format("%.3f", result) .. "万"
        elseif #tostring(math.ceil(result))==2 then
            strNum = string.format("%.2f", result) .. "万"
        elseif #tostring(math.ceil(result))==3 then
            strNum = string.format("%.1f", result) .. "万"
        elseif #tostring(math.ceil(result))==4 then
            strNum = string.format("%.0f", result) .. "万"
        end
    elseif length >= 9 then
        local result = tonumber(num) / 100000000
        if #tostring(math.ceil(result))==1 then
            strNum = string.format("%.3f", result) .. "亿"
        elseif #tostring(math.ceil(result))==2 then
            strNum = string.format("%.2f", result) .. "亿"
        elseif #tostring(math.ceil(result))==3 then
            strNum = string.format("%.1f", result) .. "亿"
        elseif #tostring(math.ceil(result))==4 then
            strNum = string.format("%.0f", result) .. "亿"
        end
    else
        strNum = num
    end
    return strNum
end

function ToolUtils.getAbsDays(strDate)
    --strDate format: 2016/05/19 
    local splitDate = ToolUtils.split(strDate, "/")
    local time = {year=splitDate[1], month=splitDate[2], day=splitDate[3]}
    local monthDay = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    local lastyear = os.date("%Y", os.time()) - 1
    local days = lastyear*365 + math.modf(lastyear/4) - math.modf(lastyear/100) + math.modf(lastyear/400)
    if((0==time.year%4 and time.year%100 ~= 0) or 0 == time.year%400) then
        monthDay[2] = monthDay[2] + 1
    end
    for i=1, time.month-1 do 
        days = days + monthDay[i]
    end
    days = days + time.day -1
    return days
end

function ToolUtils.remindTimeToRemindDate(time)
    if time <= 0 then
        return nil
    end
    
    local t1, t2 = math.modf(time / (24 * 60 * 60))
    local days = t1
    local leftTime = time - t1 * (24 * 60 * 60)
    t1, t2 = math.modf(leftTime / (60 * 60))
    local hours = t1
    leftTime = time - days * (24 * 60 * 60) - hours * (60 * 60)
    t1, t2 = math.modf(leftTime / 60)
    local minutes = t1
    local second = time - days * (24 * 60 * 60) - hours * (60 * 60) - minutes * 60
    return {["day"] = days, ["hour"] = hours, ["minute"] = minutes, ["second"] = second}
end

function ToolUtils.timeToDateStr(nTime)
    local tDate = os.date("*t", nTime)
    return string.format("%d月%d日%d时%d分", tDate.month, tDate.day, tDate.hour, tDate.min)
end

function ToolUtils.numberToIP(num)
    if num == nil then return end
    local strIP = ""
    local ip1 = bit:_and(num, 0x000000ff)
    local ip2 = bit:_rshift(bit:_and(num, 0x0000ff00), 8)
    local ip3 = bit:_rshift(bit:_and(num, 0x00ff0000), 16)
    local ip4 = bit:_rshift(bit:_and(num, 0xff000000), 24)
    strIP = string.format("%d.%d.%d.%d", ip4, ip3, ip2, ip1)
    return strIP
end

--数字转中文字符
local num2CNum = {
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
    "七",
    "八",
    "九",
    "十"
}
function ToolUtils.num2ChineseNum(num)
    if num > 10 and num < 100 then 
        return "十" .. num2CNum[num%10]
    elseif num <= 10 then 
        return num2CNum[num%10]
    else 
        return tostring(num)
    end 
end 

return ToolUtils