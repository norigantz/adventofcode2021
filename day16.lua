day16 = {}

function day16.a(arr)
    local hex = arr[4]
    local binary = ""
    for i=1,#hex do
        binary = binary..tools.hex_to_bin(hex:sub(i,i))
    end
    print(binary)
    local packets = day16.read_packet(binary)
    tools.print_table(packets)
end

function day16.b(arr) end

function day16.read_packet(binary)
    local packets = {}
    local num_packets = 0
    local packet_stack = {} -- where packet_stack[1] is the current parent packet
    local curr_word = ""
    local packet_version, type_id, length_type_id = -1, -1, -1
    local literal_value = ""
    local length_value = ""
    local curr_char_index = 1
    while #binary > 0 do
        curr_word = curr_word..binary:sub(curr_char_index,curr_char_index)
        if curr_char_index == 3 then
            num_packets = num_packets + 1
            packet_version = tonumber(curr_word, 2)
            table.insert(packets, { packet_version=packet_version })
            type_id, length_type_id, literal_value, length_value = -1, -1, "", ""
            curr_word = ""
        elseif curr_char_index == 6 then
            type_id = tonumber(curr_word, 2)
            packets[num_packets]["type_id"] = type_id
            curr_word = ""
        elseif curr_char_index > 6 and type_id == 4 and #curr_word == 5 then -- the next words of length 5 are all part of a literal
            literal_value = literal_value..curr_word:sub(2,#curr_word)
            if curr_word:sub(1,1) == "0" then
                packets[num_packets]["literal_value"] = tonumber(literal_value, 2)
                if packets[packet_stack[1]]["length_type_id"] == 0 and curr_char_index < packets[packet_stack[1]]["length_value"] then
                    binary = binary:sub(curr_char_index+1, #binary)
                    curr_char_index = 1
                elseif packets[packet_stack[1]]["length_type_id"] == 1 and num_packets < packets[packet_stack[1]]["length_value"] + 1 then
                    binary = binary:sub(curr_char_index+1, #binary)
                    curr_char_index = 1
                else
                    binary = ""
                    break
                end
            end
            curr_word = ""
        elseif curr_char_index > 6 and type_id ~= 4 and length_type_id < 0 then
            length_type_id = tonumber(curr_word, 2)
            print(length_type_id)
            packets[num_packets]["length_type_id"] = length_type_id
            curr_word = ""
        elseif length_type_id == 0 and #curr_word == 15 then -- the next 15 bits represent the total length in bits of the sub-packets contained by this packet
            length_value = tonumber(curr_word, 2)
            packets[num_packets]["length_value"] = length_value
            binary = binary:sub(curr_char_index+1,curr_char_index+1+length_value)
            table.insert(packet_stack, 1, num_packets)
            curr_char_index = 1
            curr_word = ""
        elseif length_type_id == 1 and #curr_word == 11 then -- the next 11 bits represent the number of sub-packets immediately contained by this packet
            length_value = tonumber(curr_word, 2)
            packets[num_packets]["length_value"] = length_value
            binary = binary:sub(curr_char_index+1,#binary)
            table.insert(packet_stack, 1, num_packets)
            curr_word = ""
            curr_char_index = 1
        end
        curr_char_index = curr_char_index + 1
    end
    print(num_packets)

    return packets
end

return day16