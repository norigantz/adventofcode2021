day9 = {}

function day9.a(arr)
    local heightmap = day9.build_heightmap(arr)
    local low_points = day9.find_low_points(heightmap)
    local risk_level = 0
    for a,b in pairs(low_points) do
        local x, y = b[1], b[2]
        risk_level = risk_level + heightmap[x][y] + 1
    end
    print(risk_level)
end

function day9.b(arr)
    local heightmap = day9.build_heightmap(arr)
    local low_points = day9.find_low_points(heightmap)
    local basins = {} -- basins[b], key corresponds to its low_point, value is size
    for a,b in pairs(low_points) do
        if basins[a] == nil then basins[a] = 0 end
        local x, y = b[1], b[2]
        local visited = {}
        local search = { b }
        repeat
            local next = table.remove(search, #search)
            x, y = next[1], next[2]
            table.insert(visited, next)
            basins[a] = basins[a] + 1
            for i=-1,1 do
                for j=-1,1 do
                    if i ~= j and (i == 0 or j == 0) then
                        if heightmap[x+i] ~= nil and heightmap[x+i][y+j] ~= nil and tonumber(heightmap[x+i][y+j]) < 9 and
                           not tools.table_contains(visited, { x+i, y+j }) and not tools.table_contains(search, { x+i, y+j }) then
                            table.insert(search, { x+i, y+j })
                        end
                    end
                end
            end
        until #search == 0
    end
    table.sort(basins)
    print(tonumber(basins[#basins]) * tonumber(basins[#basins-1]) * tonumber(basins[#basins-2]))
end

function day9.find_low_points(heightmap)
    local low_points = {} -- low_points[n][c] => n points, c is in [1,2] where 1 is x and 2 is y
    for x=1,#heightmap do
        for y=1,#heightmap[1] do
            local curr = heightmap[x][y]
            if heightmap[x-1] ~= nil and heightmap[x-1][y] <= curr or
               heightmap[x+1] ~= nil and heightmap[x+1][y] <= curr or
               heightmap[x][y-1] ~= nil and heightmap[x][y-1] <= curr or
               heightmap[x][y+1] ~= nil and heightmap[x][y+1] <= curr then
                goto continue
            end
            table.insert(low_points, { x, y })
            ::continue::
        end
    end
    return low_points
end

function day9.build_heightmap(arr)
    local heightmap = {} -- heightmap[x][y]
    for i=1,#arr[1] do
        local row = {}
        for j=1,#arr do
            table.insert(row, arr[j]:sub(i,i))
        end
        table.insert(heightmap, row)
    end
    return heightmap
end

return day9