day1 = {}

function day1.solve(arr, width)
    local increases = 0
    local curr_value = 0
    for a,b in pairs(arr) do
        if arr[a+width-1] == nil then break end
        local compare_to = tonumber(b)
        for i=1,width-1 do compare_to = compare_to + tonumber(arr[a+i]) end
        if curr_value ~= 0 and curr_value < compare_to then increases = increases + 1 end
        curr_value = compare_to
    end
    return increases
end

return day1