day14 = {}

local counts = {}

function day14.a(arr)
    local polymer = arr[1]
    day14.init_counts(polymer)
    local insertion_rules = day14.build_insertions(arr)
    local steps = 10
    for i=1,steps do
        polymer = day14.insert_polymers(polymer, insertion_rules)
        print(counts["H"])
    end
    print(day14.count_result(polymer))
end

function day14.b(arr)
    local polymer = arr[1]
    day14.init_counts(polymer)
    local insertion_rules = day14.build_insertions(arr)
    local steps = 40
    for i=1,steps do
        polymer = day14.insert_polymers(polymer, insertion_rules)
    end
    print(day14.count_result(polymer))
end

function day14.count_result(polymer)
    local count_array = {}
    for a,b in pairs(counts) do
        table.insert(count_array, b)
    end
    table.sort(count_array)
    return count_array[#count_array] - count_array[1]
end

function day14.insert_polymers(polymer, rules)
    for i=#polymer-1,1,-1 do
        local curr_pair = polymer:sub(i,i+1)
        if rules[curr_pair] ~= nil then
            polymer = polymer:sub(1,i)..rules[curr_pair]..polymer:sub(i+1)
            if counts[rules[curr_pair]] == nil then counts[rules[curr_pair]] = 1
            else counts[rules[curr_pair]] = counts[rules[curr_pair]] + 1 end
        end
    end
    return polymer
end

function day14.build_insertions(arr)
    local insertion_rules = {}
    for i=3,#arr do
        local rule = {}
        for s in string.gmatch(arr[i], "%a+") do
            table.insert(rule, s)
        end
        insertion_rules[rule[1]] = rule[2]
    end
    return insertion_rules
end

function day14.init_counts(polymer)
    for i=1,#polymer do
        local char = polymer:sub(i,i)
        if counts[char] == nil then counts[char] = 1
        else counts[char] = counts[char] + 1 end
    end
end

return day14