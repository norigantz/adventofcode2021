day3 = {}

function day3.a(arr)
    local word_length = arr[1]:len()
    local gamma,epsilon = 0,0
    local gamma_string = ""
    for i=1,word_length do
        local most_common = day3.most_common_bit(arr, i)
        gamma = gamma + most_common
        gamma_string = gamma_string..most_common
        epsilon = epsilon + (1 - most_common)
        if i < word_length then
            gamma = gamma << 1
            epsilon = epsilon << 1
        end
    end
    print(gamma * epsilon)
end

function day3.b(arr)
    local o2_candidates,co2_candidates = {},{}
    local most_common = day3.most_common_bit(arr, 1)
    for a,b in pairs(arr) do
        if tonumber(b:sub(1,1)) == most_common then
            table.insert(o2_candidates, b)
        else
            table.insert(co2_candidates, b)
        end
    end
    day3.search_candidates(o2_candidates, 2, true)
    day3.search_candidates(co2_candidates, 2, false)
    local o2,co2 = 0,0
    local word_length = o2_candidates[1]:len()
    for i=1,word_length do
        o2 = o2 + tonumber(o2_candidates[1]:sub(i,i))
        co2 = co2 + tonumber(co2_candidates[1]:sub(i,i))
        if i < word_length then
            o2 = o2 << 1
            co2 = co2 << 1
        end
    end
    print(o2 * co2)
end

function day3.search_candidates(arr, digit, match)
    while #arr > 1 do
        local most_common = day3.most_common_bit(arr, digit)
        for i=#arr,1,-1 do
            if match then
                if tonumber(arr[i]:sub(digit,digit)) ~= most_common then table.remove(arr, i) end
            else
                if tonumber(arr[i]:sub(digit,digit)) == most_common then table.remove(arr, i) end
            end
        end
        digit = digit + 1
    end
    return arr
end

function day3.most_common_bit(arr, digit)
    local count_0,count_1 = 0,0
    for a,b in pairs(arr) do
        if b:sub(digit,digit) == "0" then
            count_0 = count_0 + 1
        else
            count_1 = count_1 + 1
        end
    end
    if count_0 > count_1 then
        return 0
    else
        return 1
    end
end

return day3