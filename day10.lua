day10 = {}

function day10.a(arr)
    local score = 0
    for a,b in pairs(arr) do
        local invalid_char = day10.validate_chunks(b)[1]
        if invalid_char == ")" then score = score + 3
        elseif invalid_char == "]" then score = score + 57
        elseif invalid_char == "}" then score = score + 1197
        elseif invalid_char == ">" then score = score + 25137
        end
    end
    print(score)
end

function day10.b(arr)
    local line_scores = {}
    for a,b in pairs(arr) do
        local validation = day10.validate_chunks(b)
        if validation[1] == "" then
            local opens = validation[2]
            local line_score = 0
            for i=#opens,1,-1 do
                if opens:sub(i,i) == "(" then line_score = line_score * 5 + 1
                elseif opens:sub(i,i) == "[" then line_score = line_score * 5 + 2
                elseif opens:sub(i,i) == "{" then line_score = line_score * 5 + 3
                elseif opens:sub(i,i) == "<" then line_score = line_score * 5 + 4 end
            end
            table.insert(line_scores, line_score)
        end
    end
    table.sort(line_scores)
    print(line_scores[#line_scores//2+1])
end

function day10.validate_chunks(line)
    local opens = "" -- match with the last character and truncate the last character, like a stack
    local invalid_char
    for i=1,#line do
        invalid_char = line:sub(i,i)
        if invalid_char == "(" or invalid_char == "[" or invalid_char == "{" or invalid_char == "<" then
            opens = opens..invalid_char
        elseif invalid_char == ")" or invalid_char == "]" or invalid_char == "}" or invalid_char == ">" then
            if day10.match_brackets(opens:sub(#opens,#opens), invalid_char) then opens = opens:sub(1,#opens-1)
            else return { invalid_char, opens } end
        end
    end
    invalid_char = ""
    return { invalid_char, opens }
end

function day10.match_brackets(open, close)
    return open == "(" and close == ")" or open == "[" and close == "]" or open == "{" and close == "}" or open == "<" and close == ">"
end

return day10