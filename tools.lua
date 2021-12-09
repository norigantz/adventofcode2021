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

return tools