day4 = {}

function day4.a(arr)
    local game_sequence = day4.init_game_sequence(arr)
    local bingo_boards = day4.init_bingo_boards(arr)
    local call_table = day4.init_call_table(arr)
    local winning_board, last_called
    for a,b in pairs(game_sequence) do
        call_table[b] = true
        if a >= 5 then
            winning_board = day4.find_winner(call_table, bingo_boards)
            if winning_board > 0 then
                last_called = b
                break
            end
            last_called = b
        end
    end
    print(day4.calculate_score(call_table, bingo_boards, winning_board, last_called))
end

function day4.b(arr)
    local game_sequence = day4.init_game_sequence(arr)
    local bingo_boards = day4.init_bingo_boards(arr)
    local call_table = day4.init_call_table(arr)
    local worst_candidate, last_called
    for a,b in pairs(game_sequence) do
        call_table[b] = true
        if a >= 5 then
            worst_candidate = day4.find_winner(call_table, bingo_boards)
            if worst_candidate > 0 then
                if #bingo_boards > 1 then
                    while worst_candidate > 0 do
                        table.remove(bingo_boards, worst_candidate)
                        worst_candidate = day4.find_winner(call_table, bingo_boards)
                    end
                else
                    last_called = b
                    break
                end
            end
            last_called = b
        end
    end
    print(day4.calculate_score(call_table, bingo_boards, worst_candidate, last_called))
end

function day4.calculate_score(call_table, bingo_boards, board, last_called)
    local sum = 0
    for j=1,5 do
        for k=1,5 do
            if call_table[bingo_boards[board][j][k]] == false then
                sum = sum + bingo_boards[board][j][k]
            end
        end
    end
    return sum * last_called
end

function day4.find_winner(call_table, bingo_boards)
    for i=1,#bingo_boards do
        for j=1,#bingo_boards[i] do
            for k=1,5 do
                if call_table[bingo_boards[i][j][k]] == false then goto continue
                elseif k == 5 then return i end
            end
            ::continue::
        end
    end
    return 0
end

function day4.init_game_sequence(arr)
    local game_sequence = {} -- array of numbers in the bingo sequence order
    for n in string.gmatch(arr[1], "%d+") do
        table.insert(game_sequence, tonumber(n))
    end
    return game_sequence
end

function day4.init_bingo_boards(arr)
    local bingo_boards = {} -- array of all possible boards to choose from
    for i=3,#arr,6 do
        local board = {} -- array of size 10, composing 5 rows and 5 columns
        for j=0,4 do
            local row = {} -- array of size 5, composing 1 row
            for n in string.gmatch(arr[i+j], "%d+") do
                table.insert(row, tonumber(n))
            end
            table.insert(board, row)
        end
        for j=1,5 do
            local col = {} -- array of size 5, composing 1 column
            for k=1,5 do
                table.insert(col, board[k][j])
            end
            table.insert(board, col)
        end
        table.insert(bingo_boards, board)
    end
    return bingo_boards
end

function day4.init_call_table(arr)
    local call_table = {} -- table with integer keys 0-99 that reports whether a number was called in the sequence
    for i=0,99 do
        call_table[i] = false
    end
    return call_table
end

return day4