day6 = {}

function day6.a(arr)
    print(day6.solve(arr, 80))
end

function day6.b(arr)
    print(day6.solve(arr, 256))
end

function day6.solve(arr, days)
    local fish = {}
    for n in string.gmatch(arr[1], "%d+") do
        local index = tonumber(n)
        if fish[index] == nil then fish[index] = 1
        else fish[index] = fish[index] + 1 end
    end
    fish[0] = 0
    fish[6] = 0
    fish[8] = 0
    for i=1,days do
        local cached_zeros = fish[0]
        for f=0,#fish do
            if fish[f+1] ~= nil then
                fish[f] = fish[f+1]
            else
                fish[f] = 0
            end
        end
        fish[6] = fish[6] + cached_zeros
        fish[8] = fish[8] + cached_zeros
    end
    local sum = 0
    for i=0,#fish do
        sum = sum + fish[i]
    end
    return sum
end

return day6