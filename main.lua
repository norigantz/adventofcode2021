require "tools"
require "day1"
require "day2"
require "day3"
require "day4"
require "day5"
require "day6"
require "day7"
require "day8"
require "day9"
require "day10"
require "day11"
require "day12"
require "day13"
require "day14"
require "day15"
require "day16"

-- Usage: lua main [day_number] [input_file]
local arr = tools.read("in/"..arg[2])
if     arg[1] == "1a" then day1.a(arr)
elseif arg[1] == "1b" then day1.b(arr)
elseif arg[1] == "2a" then day2.a(arr)
elseif arg[1] == "2b" then day2.b(arr)
elseif arg[1] == "3a" then day3.a(arr)
elseif arg[1] == "3b" then day3.b(arr)
elseif arg[1] == "4a" then day4.a(arr)
elseif arg[1] == "4b" then day4.b(arr)
elseif arg[1] == "5a" then day5.a(arr)
elseif arg[1] == "5b" then day5.b(arr)
elseif arg[1] == "6a" then day6.a(arr)
elseif arg[1] == "6b" then day6.b(arr)
elseif arg[1] == "7a" then day7.a(arr)
elseif arg[1] == "7b" then day7.b(arr)
elseif arg[1] == "8a" then day8.a(arr)
elseif arg[1] == "8b" then day8.b(arr)
elseif arg[1] == "9a" then day9.a(arr)
elseif arg[1] == "9b" then day9.b(arr)
elseif arg[1] == "10a" then day10.a(arr)
elseif arg[1] == "10b" then day10.b(arr)
elseif arg[1] == "11a" then day11.a(arr)
elseif arg[1] == "11b" then day11.b(arr)
elseif arg[1] == "12a" then day12.a(arr)
elseif arg[1] == "12b" then day12.b(arr)
elseif arg[1] == "13a" then day13.a(arr)
elseif arg[1] == "13b" then day13.b(arr)
elseif arg[1] == "14a" then day14.a(arr)
elseif arg[1] == "14b" then day14.b(arr)
elseif arg[1] == "15a" then day15.a(arr)
elseif arg[1] == "15b" then day15.b(arr)
elseif arg[1] == "16a" then day16.a(arr)
elseif arg[1] == "16b" then day16.b(arr)
end