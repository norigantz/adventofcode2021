day14 = {}

function day14.a(arr)
    print(day14.solve(arr, 10))
end

function day14.b(arr)
    print(day14.solve(arr, 40))
end

function day14.solve(arr, steps)
    local pair_counts = {}
    local rules = {}

    -- Init pair_counts to 0 and insertion rules lookup
    for i=3,#arr do
        local rule = {}
        for s in string.gmatch(arr[i], "%a+") do
            table.insert(rule, s)
        end
        pair_counts[rule[1]] = 0
        rules[rule[1]] = rule[2]
    end

    -- Init pair_counts with initial polymer string
    local polymer = arr[1]
    for i=1,#polymer-1 do
        pair_counts[polymer:sub(i,i+1)] = pair_counts[polymer:sub(i,i+1)] + 1
    end

    -- Run insertion rules
    local step = steps
    for i=1,step do
        -- Init next pair count table to 0
        local next_pair_counts = {}
        for i=3,#arr do
            local rule = {}
            for s in string.gmatch(arr[i], "%a+") do
                table.insert(rule, s)
            end
            next_pair_counts[rule[1]] = 0
        end

        -- Increment next pair counts by current pair counts based on rules
        for a,b in pairs(pair_counts) do
            if b > 0 then
                next_pair_counts[a:sub(1,1)..rules[a]] = next_pair_counts[a:sub(1,1)..rules[a]] + b
                next_pair_counts[rules[a]..a:sub(2,2)] = next_pair_counts[rules[a]..a:sub(2,2)] + b
            end
        end

        -- Set pair counts to next pair counts
        for a,b in pairs(pair_counts) do
            pair_counts[a] = next_pair_counts[a]
        end
    end

    -- Counting chars
    local char_counts = {}
    for a,b in pairs(pair_counts) do
        for i=1,2 do
            local char = a:sub(i,i)
            if char_counts[char] == nil then
                char_counts[char] = b
            else
                char_counts[char] = char_counts[char] + b
            end
        end
    end

    -- Since each char appears in two pairs, except the edges: dividing by two scheme
    for a,b in pairs(char_counts) do
        if a == polymer:sub(1,1) or a == polymer:sub(#polymer,#polymer) then
            char_counts[a] = char_counts[a] + 1
        end
        char_counts[a] = char_counts[a] // 2
    end

    -- Sorting
    local char_counts_arr = {}
    for a,b in pairs(char_counts) do
        table.insert(char_counts_arr, b)
    end
    table.sort(char_counts_arr)

    return char_counts_arr[#char_counts_arr] - char_counts_arr[1]
end

return day14