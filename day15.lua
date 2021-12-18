day15 = {}

function day15.a(arr)
    local riskmap = tools.build_grid(arr)
    local width = #arr[1]
    print(day15.min_cost(riskmap, width, false))
end

function day15.b(arr)
    local riskmap = tools.build_grid(arr)
    local width = #arr[1]
    print(day15.min_cost(day15.build_full_map(riskmap), width*5, true))
end

function day15.min_cost(riskmap, width, full)
    -- init unvisited to all positions and all distances to maxinteger
    local unvisited = {}
    local distances = {}
    for i=1,width do
        for j=1,width do
            if i > 0 and i <= width and j > 0 and j <= width then
                table.insert(unvisited, { i, j })
                distances[tools.idx(i, j, width)] = math.maxinteger
            end
        end
    end

    -- set curr position, start at 1,1 with cost of 0
    local curr = { 1, 1 }
    distances[tools.idx(curr[1], curr[2], width)] = 0

    while #unvisited > 0 do
        -- set tentative distances to all neighbors of curr
        for i=0,1 do--1,1 do
            for j=0,1 do---1,1 do
                if i ~= j then--i + j ~= 0 and (i == 0 or j == 0) then
                    local x, y = curr[1]+i, curr[2]+j
                    if x > 0 and y > 0 and x <= width and y <= width then
                        local risk = riskmap[x][y]
                        local new_distance = distances[tools.idx(curr[1], curr[2], width)] + risk
                        if new_distance < distances[tools.idx(x, y, width)] then distances[tools.idx(x, y, width)] = new_distance end
                    end
                end
            end
        end

        -- remove curr from unvisited
        for i=#unvisited,1,-1 do
            if curr[1] == unvisited[i][1] and curr[2] == unvisited[i][2] then table.remove(unvisited, i) end
        end

        -- select a new curr
        local min_next = unvisited[1]
        for a,b in pairs(unvisited) do
            if distances[tools.idx(b[1], b[2], width)] < distances[tools.idx(min_next[1], min_next[2], width)] then min_next = b end
        end
        curr = min_next

        -- if curr is the bottom right corner, return the cost
        if curr[1] == width and curr[2] == width then return distances[tools.idx(curr[1], curr[2], width)] end
    end
end

function day15.build_full_map(riskmap)
    local fullmap = {}
    local width = #riskmap[1]
    for k=1,5 do
        for i=1,width do
            local row = {}
            for j=1,width do
                local val = riskmap[i][j]+k-1
                if val > 9 then val = val%10 + 1 end
                table.insert(row, val)
            end
            table.insert(fullmap, row)
        end
    end
    for k=1,5 do
        for i=1,width*5 do
            for j=1,width*k do
                local val = fullmap[i][j]+k
                if val > 9 then val = val%10 + 1 end
                table.insert(fullmap[i], val)
            end
        end
    end
    tools.print_grid(fullmap)
    return fullmap
end

return day15