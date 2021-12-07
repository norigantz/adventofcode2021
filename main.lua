require "tools"
require "day1"
require "day2"
require "day3"
require "day4"

-- Usage: lua main [day_number] [input_file]
local arr = tools.read("in/"..arg[2])
if     arg[1] == "1a" then day1.a(arr)
elseif arg[1] == "1b" then day1.b(arr)
elseif arg[1] == "2a" then day2.a(arr)
elseif arg[1] == "2b" then day2.b(arr)
elseif arg[1] == "3a" then day3.a(arr)
elseif arg[1] == "3b" then day3.b(arr)
elseif arg[1] == "4a" then day4.a(arr)
elseif arg[1] == "4b" then day4.b(arr) end