day12 = {}

function day12.a(edge_list)
    local edges = day12.build_edges(edge_list)
    local paths = {}
    day12.find_paths(edges, paths, {}, "start", false, false)
    print(#paths)
end

function day12.b(edge_list)
    local edges = day12.build_edges(edge_list)
    local paths = {}
    day12.find_paths(edges, paths, {}, "start", true, false)
    print(#paths)
end

function day12.find_paths(edges, paths, path, curr, allow_revisit, small_revisited)
    local curr_path = {}
    for a,b in pairs(path) do
        table.insert(curr_path, b)
    end
    table.insert(curr_path, curr)
    if curr == "end" then
        table.insert(paths, curr_path)
    else
        for a,b in pairs(edges[curr]) do
            local can_revisit = false
            if allow_revisit and not small_revisited and b ~= "start" and b ~= "end" and string.match(b, "%u") == nil and tools.table_contains(curr_path, b) then can_revisit = true end
            if string.match(b, "%u") ~= nil or not tools.table_contains(curr_path, b) or can_revisit then
                day12.find_paths(edges, paths, curr_path, b, allow_revisit, small_revisited or can_revisit)
            end
        end
    end
end

function day12.build_edges(edge_list)
    local edges = {}
    for a,b in pairs(edge_list) do
        local nodes = {}
        for node in string.gmatch(b, "%a+") do
            table.insert(nodes, node)
        end
        if edges[nodes[1]] == nil then edges[nodes[1]] = { nodes[2] }
        else table.insert(edges[nodes[1]], nodes[2]) end
        if edges[nodes[2]] == nil then edges[nodes[2]] = { nodes[1] }
        else table.insert(edges[nodes[2]], nodes[1]) end
    end
    return edges
end

return day12