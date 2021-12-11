day11 = {}

local energymap
local flashers = {} -- running list of octos over 9

function day11.a(arr)
    energymap = tools.build_grid(arr)
    local steps = 100
    local flashes = 0
    for i=1,steps do
        day11.increment_octos()
        flashes = flashes + day11.resolve_flashers()
    end
    print(flashes)
end

function day11.b(arr)
    energymap = tools.build_grid(arr)
    local flashes = 0
    local step_count = 0
    while flashes ~= #energymap * #energymap[1] do
        day11.increment_octos()
        flashes = day11.resolve_flashers()
        step_count = step_count + 1
    end
    print(step_count)
end

function day11.resolve_flashers()
    local flashed_this_step = {}
    local flashes = 0
    while #flashers > 0 do
        local new_flashers = {}
        for f=#flashers,1,-1 do
            local x, y = flashers[f][1], flashers[f][2]
            energymap[x][y] = 0
            flashes = flashes + 1
            table.insert(flashed_this_step, { x, y })
            for f1=-1,1 do
                for f2=-1,1 do
                    if (f1 ~= 0 or f2 ~= 0) and x+f1 > 0 and x+f1 <= #energymap and y+f2 > 0 and y+f2 <= #energymap[1] then
                        energymap[x+f1][y+f2] = energymap[x+f1][y+f2] + 1
                        if energymap[x+f1][y+f2] > 9 and
                            not tools.table_contains(flashers, { x+f1, y+f2 }) and
                            not tools.table_contains(new_flashers, { x+f1, y+f2 }) then
                            table.insert(new_flashers, { x+f1, y+f2 })
                        end
                    end
                end
            end
            table.remove(flashers, f)
        end
        for a,new in pairs(new_flashers) do
            table.insert(flashers, new)
        end
    end
    for a,b in pairs(flashed_this_step) do
        energymap[b[1]][b[2]] = 0
    end
    return flashes
end

function day11.increment_octos()
    for x=1,#energymap do
        for y=1,#energymap[1] do
            energymap[x][y] = energymap[x][y] + 1
            if energymap[x][y] > 9 then table.insert(flashers, { x, y }) end
        end
    end
end

return day11