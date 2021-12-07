require "tools"
require "day1"
require "day2"
require "day3"

-- Usage: lua main [day_number] [input_file] [day-specific arg]
local arr = tools.read("in/"..arg[2])
if     arg[1] == "1" then day1.solve(arr, arg[3])
elseif arg[1] == "2a" then day2.a(arr)
elseif arg[1] == "2b" then day2.b(arr)
elseif arg[1] == "3a" then day3.a(arr)
elseif arg[1] == "3b" then day3.b(arr) end