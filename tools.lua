tools = {}

function tools.read(file_name)
    local output_arr = {}
    local file = io.open(file_name, "r")
    for line in file:lines() do
        table.insert(output_arr, line)
    end
    return output_arr
end

function tools.print_table(t)
    print(t)
    for a,b in pairs(t) do
        if type(b) == "table" then
            tools.print_table(b)
        else
            print(a,b)
        end
    end
end

function tools.print_grid(t) -- table[x][y]
    for y=1,#t[1] do
        local s = ""
        for x=1,#t do
            s = s..t[x][y]
        end
        print(s)
    end
end

function tools.build_grid(t) -- builds table grid with indices [x][y]
    local grid = {}
    for i=1,#t[1] do
        local row = {}
        for j=1,#t do
            table.insert(row, t[j]:sub(i,i))
        end
        table.insert(grid, row)
    end
    return grid
end

function tools.idx(x, y, width)
    return y*width + x
end

function tools.table_contains(t, item)
    for i=1,#t do
        if #item == #t[i] then
            if #item == 1 or type(item) == "string" then
                if item == t[i] then return true end
            else
                for j=1,#item do
                    if item[j] ~= t[i][j] then goto continue
                    elseif j == #item then return true end
                end
            end
        end
        ::continue::
    end
    return false
end

return tools