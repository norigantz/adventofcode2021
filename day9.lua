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

    for a,b in pairs(low_points) do
        
    end
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
            local pair = {}
            table.insert(pair, x)
            table.insert(pair, y)
            table.insert(low_points,pair)
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