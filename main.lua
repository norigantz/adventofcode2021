require "tools"
require "day1"
require "day2"
require "day3"

-- Usage: lua main [day_number] [input_file] [day-specific arg]
local arr = tools.read("in/"..arg[2])
if     arg[1] == "1" then print(day1.solve(arr, arg[3]))
elseif arg[1] == "2a" then print(day2.a(arr)) 
elseif arg[1] == "2b" then print(day2.b(arr))
elseif arg[1] == "3" then print(day3.solve(arr)) end