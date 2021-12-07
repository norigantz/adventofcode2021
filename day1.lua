day1 = {}

function day1.a(arr)
    day1.solve(arr, 1)
end

function day1.b(arr)
    day1.solve(arr, 3)
end

function day1.solve(arr, width)
    local increases,curr_value = 0,0
    for a,b in pairs(arr) do
        if arr[a+width-1] == nil then break end
        local compare_to = tonumber(b)
        for i=1,width-1 do compare_to = compare_to + tonumber(arr[a+i]) end
        if curr_value ~= 0 and curr_value < compare_to then increases = increases + 1 end
        curr_value = compare_to
    end
    print(increases)
end

return day1