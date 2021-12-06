day3 = {}

function day3.solve(arr)
    local word_length = arr[1]:len()
    local gamma = 0
    local epsilon = 0
    for i=1,word_length do
        local count_0 = 0
        local count_1 = 0
        for a,b in pairs(arr) do
            if b:sub(i,i) == "0" then
                count_0 = count_0 + 1
            else
                count_1 = count_1 + 1
            end
        end
        local most_common = 0
        if count_1 > count_0 then
            most_common = 1
        end
        gamma = (gamma + most_common)
        epsilon = (epsilon + (1 - most_common))
        if i < word_length then
            gamma = gamma << 1
            epsilon = epsilon << 1
        end
    end
    return gamma * epsilon
end

return day3