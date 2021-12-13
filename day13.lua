day13 = {}

function day13.a(arr)
    local dots = day13.build_dots(arr)
    day13.fold_dots(dots, { 655, 0 })
    print(#dots)
end

function day13.b(arr)
    local dots = day13.build_dots(arr)
    for i=#dots+1,#arr do
        if arr[i]:sub(1,1) == "f" then
            if string.match(arr[i], "x") ~= nil then
                for n in string.gmatch(arr[i], "%d+") do
                    day13.fold_dots(dots, { tonumber(n), 0 })
                end
            else
                for n in string.gmatch(arr[i], "%d+") do
                    day13.fold_dots(dots, { 0, tonumber(n) })
                end
            end
        end
    end
    local width, height = 0, 0
    for a,b in pairs(dots) do
        if b[1] > width then width = b[1] end
        if b[2] > height then height = b[2] end
    end
    day13.print_dots(dots, width, height)
end

function day13.fold_dots(dots, fold)
    local remove_dots = {}
    for a,b in pairs(dots) do
        if fold[1] ~= 0 and b[1] > fold[1] then -- x fold
            if not tools.table_contains(dots, { fold[1]-(b[1]-fold[1]), b[2] }) then table.insert(dots, { fold[1]-(b[1]-fold[1]), b[2] }) end
            table.insert(remove_dots, b)
        elseif fold[2] ~= 0 and b[2] > fold[2] then -- y fold
            if not tools.table_contains(dots, { b[1], fold[2]-(b[2]-fold[2]) }) then table.insert(dots, { b[1], fold[2]-(b[2]-fold[2]) }) end
            table.insert(remove_dots, b)
        end
    end
    for a,b in pairs(remove_dots) do
        for i=#dots,1,-1 do
            if dots[i][1] == b[1] and dots[i][2] == b[2] then table.remove(dots, i) end
        end
    end
end

function day13.build_dots(arr)
    local dots = {}
    for a,b in pairs(arr) do
        if b:sub(1,1) ~= "f" and b:sub(1,1) ~= "" then
            local pair = {}
            for n in string.gmatch(b, "%d+") do
                table.insert(pair, tonumber(n))
            end
            table.insert(dots, pair)
        end
    end
    return dots
end

function day13.print_dots(dots, width, height)
    for i=0,height do
        local s = ""
        for j=0,width do
            if tools.table_contains(dots, { j, i }) then s = s.."#"
            else s = s.."." end
        end
        print(s)
    end
end

return day13