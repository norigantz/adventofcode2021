require "tools"
require "day1"

local arr = tools.read("in/"..arg[1])
print(day1.solve(arr, arg[2]))