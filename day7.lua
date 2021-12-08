day7 = {}

function day7.a(arr)
    day7.solve(arr, false)
end

function day7.b(arr)
    day7.solve(arr, true)
end

function day7.solve(arr, triangle)
    local crab_positions = {}
    for n in string.gmatch(arr[1], "%d+") do
        table.insert(crab_positions, tonumber(n))
    end
    table.sort(crab_positions)
    local position_costs = {}
    for pos=crab_positions[1],crab_positions[#crab_positions] do
        if position_costs[pos] == nil then position_costs[pos] = 0 end
        for a,b in pairs(crab_positions) do
            if pos ~= b then
                if triangle then
                    position_costs[pos] = position_costs[pos] + day7.triangle(math.abs(b - pos))
                else
                    position_costs[pos] = position_costs[pos] + math.abs(b - pos)
                end
            end
        end
    end
    local min_position = crab_positions[1]
    for a,b in pairs(position_costs) do
        if b < position_costs[min_position] then min_position = a end
    end
    print(position_costs[min_position])
end

function day7.triangle(n)
    local tri = 0
    for i=1,n do
        tri = tri + i
    end
    return tri
end

return day7