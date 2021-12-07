day5 = {}

function day5.a(arr)
    local points = {} -- table of all point indices (mapped to 1D) in the space, value is level of danger
    local grid_width = 10
    local lines = day5.init_lines(arr)
    local danger_table = {}
    print(day5.calculate_danger(lines, points, danger_table, grid_width, false))
end

function day5.b(arr)
    local points = {}
    local grid_width = 1000
    local lines = day5.init_lines(arr)
    local danger_table = {}
    print(day5.calculate_danger(lines, points, danger_table, grid_width, true))
end

function day5.calculate_danger(lines, points, danger_table, grid_width, diagonals)
    for a,b in pairs(lines) do
        if not diagonals and b[1] ~= b[3] and b[2] ~= b[4] then goto continue end
        local x1, x2, y1, y2, dx, dy = b[1], b[3], b[2], b[4], 0, 0
        if b[1] < b[3] then
            x1 = b[1]
            y1 = b[2]
            x2 = b[3]
            y2 = b[4]
            dx = 1
        elseif b[1] > b[3] then
            x1 = b[3]
            y1 = b[4]
            x2 = b[1]
            y2 = b[2]
            dx = 1
        end
        if y1 ~= y2 then
            if y1 > y2 then
                dy = -1
            else
                dy = 1
            end
        end
        if dx ~= 0 or dy ~= 0 then
            local currX, currY = x1, y1
            while currX ~= x2+dx or currY ~= y2+dy do
                local index = currY*grid_width+currX
                if points[index] == nil then
                    points[index] = 1
                else
                    points[index] = points[index] + 1
                    if points[index] > 1 then danger_table[index] = true end
                end
                currX = currX + dx
                currY = currY + dy
            end
        end
        ::continue::
    end
    local danger_count = 0
    for a,b in pairs(danger_table) do
        danger_count = danger_count + 1
    end
    return danger_count
end

function day5.init_lines(arr)
    local lines = {} -- array of all lines
    for a,b in pairs(arr) do
        local line = {}
        for n in string.gmatch(b, "%d+") do
            table.insert(line, tonumber(n))
        end
        table.insert(lines, line)
    end
    return lines
end

return day5