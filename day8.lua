day8 = {}

function day8.a(arr)
    local easy_count = 0
    for a,b in pairs(arr) do
        for s in string.gmatch(b, "%a+", 60) do
            if #s == 2 or #s == 3 or #s == 4 or #s == 7 then easy_count = easy_count + 1 end
        end
    end
    print(easy_count)
end

function day8.b(arr)
    local notes = {}
    for a,b in pairs(arr) do
        local entry = {}
        for s in string.gmatch(b, "%a+") do
            table.insert(entry, s)
        end
        table.insert(notes, entry)
    end

    local result = 0
    for a,b in pairs(notes) do
        result = result + day8.translate_output(b, day8.decrypt_note(b))
    end
    print(result)
end

function day8.translate_output(note, decrypt)
    local output = ""
    for i=#note,#note-3,-1 do -- for the last four words in the note
        for a,b in pairs(decrypt) do -- for each decryption pair
            if #b == #note[i] then -- if the length of the word matches the decrypted word
                for j=1,#b do -- for the length of the word
                    if string.match(note[i], b:sub(j,j)) == nil then goto continue-- if a character from the output word is not in the decryption word, try the next decryption word
                    elseif j == #b then output = a..output end
                end
            end
            ::continue::
        end
    end
    return tonumber(output)
end

function day8.decrypt_note(note)
    -- number of segments => possible values
    -- 2 => 1
    -- 3 => 7
    -- 4 => 4
    -- 5 => 2, 3, 5
    -- 6 => 0, 6, 9
    -- 7 => 8
    local decrypt = {}
    for a,b in pairs(note) do
        if #b == 2 then decrypt[1] = b
        elseif #b == 3 then decrypt[7] = b
        elseif #b == 4 then decrypt[4] = b
        elseif #b == 7 then decrypt[8] = b
        end
    end

    for a,b in pairs(note) do
        if #b == 6 then -- this number is missing only one segment vs 8
            local missing_letter
            for i=1,7 do
                missing_letter = decrypt[8]:sub(i,i)
                if string.match(b, missing_letter) == nil then
                    if decrypt[6] == nil and string.match(decrypt[7], missing_letter) then decrypt[6] = b -- if the missing letter is in 7, the value is 6
                    elseif decrypt[0] == nil and string.match(decrypt[4], missing_letter) then decrypt[0] = b -- if the missing letter is in 4, the value is 0
                    elseif decrypt[9] == nil then decrypt[9] = b -- otherwise the value is 9
                    end
                end
            end
        end
    end

    for a,b in pairs(note) do
        if #b == 5 then -- this number is missing only one segment vs 9
            local missing_from_nine, missing_from_six = 0,0
            for i=1,6 do
                local curr_letter = decrypt[9]:sub(i,i)
                if string.match(b, curr_letter) == nil then missing_from_nine = missing_from_nine + 1 end
                curr_letter = decrypt[6]:sub(i,i)
                if string.match(b, curr_letter) == nil then missing_from_six = missing_from_six + 1 end
            end
            if decrypt[5] == nil and missing_from_six == 1 then decrypt[5] = b -- if only one letter is missing vs 6, the value is 5
            elseif decrypt[2] == nil and missing_from_nine == 2 then decrypt[2] = b -- if two letters are missing vs nine, the value is 2
            elseif decrypt[3] == nil then decrypt[3] = b -- otherwise the value is 3
            end
        end
    end

    return decrypt
end

return day8