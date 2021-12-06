tools = {}

function tools.read(file_name)
    local output_arr = {}
    local file = io.open(file_name, "r")
    for line in file:lines() do
        table.insert(output_arr, line)
    end
    return output_arr
end

return tools