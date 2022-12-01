
def elfs_ordered_calories
  calories_list = File.open("elfs_calories.txt").read.split("\n")
  ordered_calories = []
  total_cal = 0
  calories_list.each do |line|
    total_cal += line.to_i
    if line.strip == ""
      ordered_calories.push(total_cal)
      total_cal = 0
    end
  end
  ordered_calories.sort
end

elfs_calories =  elfs_ordered_calories

# Part 1 Solution:

puts "Part 1 \n"
puts "Elf with most calories: #{elfs_calories[elfs_calories.length - 1]} \n\n"

# Part 2 Solution
total_calories = 0

for i in (elfs_calories.length - 3) .. (elfs_calories.length - 1) do
  total_calories += elfs_calories[i]
end

puts "Part 2 \n"
puts "Sum of top 3 elf's calories: #{total_calories}"


