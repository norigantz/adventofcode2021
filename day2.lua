day2 = {}

function day2.a(arr)
    local horizontal,depth = 0,0
    for a,b in pairs(arr) do
        local instruction = string.match(b, "%a+")
        local value = tonumber(string.match(b, "%d+"))
        if     instruction == "forward" then horizontal = horizontal + value
        elseif instruction == "down" then depth = depth + value
        elseif instruction == "up" then depth = depth - value end
    end
    print(horizontal * depth)
end

function day2.b(arr)
    local horizontal,depth,aim = 0,0,0
    for a,b in pairs(arr) do
        local instruction = string.match(b, "%a+")
        local value = tonumber(string.match(b, "%d+"))
        if     instruction == "forward" then
            horizontal = horizontal + value
            depth = depth + (aim * value)
        elseif instruction == "down" then aim = aim + value
        elseif instruction == "up" then aim = aim - value end
    end
    print(horizontal * depth)
end

return day2