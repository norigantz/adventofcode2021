tools = {}

function tools.read(file_name)
    local output_arr = {}
    local file = io.open(file_name, "r")
    for line in file:lines() do
        table.insert(output_arr, line)
    end
    return output_arr
end

function tools.print_table(table)
    print(table)
    for a,b in pairs(table) do
        if type(b) == "table" then
            tools.print_table(b)
        else
            print(a,b)
        end
    end
end

function tools.idx(x, y, width)
    return y*width + x
end

function tools.table_contains(table, item)
    for i=1,#table do
        if #item == #table[i] then
            for j=1,#item do
                if item[j] ~= table[i][j] then goto continue
                elseif j == #item then return true end
            end
        end
        ::continue::
    end
    return false
end

return tools