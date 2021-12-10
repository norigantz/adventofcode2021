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
            if heightmap[x-1] ~= nil and tonumber(heightmap[x-1][y]) < 9 then
                for va,vb in pairs(visited) do
                    if x-1 == vb[1] and y == vb[2] then goto continue end
                end
                for sa,sb in pairs(search) do
                    if x-1 == sb[1] and y == sb[2] then goto continue end
                end
                table.insert(search, { x-1, y })
                ::continue::
            end
            if heightmap[x+1] ~= nil and tonumber(heightmap[x+1][y]) < 9 then
                for va,vb in pairs(visited) do
                    if x+1 == vb[1] and y == vb[2] then goto continue end
                end
                for sa,sb in pairs(search) do
                    if x+1 == sb[1] and y == sb[2] then goto continue end
                end
                table.insert(search, { x+1, y })
                ::continue::
            end
            if heightmap[x][y-1] ~= nil and tonumber(heightmap[x][y-1]) < 9 then
                for va,vb in pairs(visited) do
                    if x == vb[1] and y-1 == vb[2] then goto continue end
                end
                for sa,sb in pairs(search) do
                    if x == sb[1] and y-1 == sb[2] then goto continue end
                end
                table.insert(search, { x, y-1 })
                ::continue::
            end
            if heightmap[x][y+1] ~= nil and tonumber(heightmap[x][y+1]) < 9 then
                for va,vb in pairs(visited) do
                    if x == vb[1] and y+1 == vb[2] then goto continue end
                end
                for sa,sb in pairs(search) do
                    if x == sb[1] and y+1 == sb[2] then goto continue end
                end
                table.insert(search, { x, y+1 })
                ::continue::
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