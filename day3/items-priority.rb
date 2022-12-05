@item_priority_guide = {}
@rucksack_list = nil

def items_priority
  sorted_compartments = get_sorted_compartments
  
  matching_items = []
  sorted_compartments.each do |compartments|
    matching_items.push(find_matching_item(compartments))
  end
  
  matching_items_total = 0
  matching_items.each do |item|
    matching_items_total += @item_priority_guide[item[:matching_item].to_sym].to_i
  end
  puts "Total Matching Item's value: #{matching_items_total}"
end

def group_badge_item(line_count)
  sorted_lines = get_sorted_lines
  group = {}
  total_badge_items_priority = 0
  i = 1
  sorted_lines.each_with_index do |line, index|
    group["elf_#{i}".to_sym] = line[:line]
    if i % line_count == 0 or index == sorted_lines.length - 1
      total_badge_items_priority += get_badge_item(group)
      group = {}
      i = 0
    end
    i += 1
  end
  puts "Total Badge's Items Priority: #{total_badge_items_priority}"
end

def set_item_priority_level
  i = 1
  ('a'..'z').to_a.each do |letter| 
    @item_priority_guide[letter.to_sym] = i
    i += 1
  end
  ('A'..'Z').to_a.each do |letter| 
    @item_priority_guide[letter.to_sym] = i
    i += 1
  end
end

def get_sorted_compartments
  sorted_compartments = []
  @rucksack_list.each_with_index do |rucksack, i|
    compartments = { id: i, first: (rucksack[0..((rucksack.length / 2) - 1)]).chars.sort, second: (rucksack[(rucksack.length / 2)..rucksack.length - 1]).chars.sort}
    sorted_compartments.push(compartments)
  end
  sorted_compartments
end

def get_sorted_lines
  sorted_compartments = []
  @rucksack_list.each_with_index do |rucksack, i|
    compartments = { line: rucksack.chars.sort}
    sorted_compartments.push(compartments)
  end
  sorted_compartments
end

def find_matching_item(compartments)
  first = compartments[:first]
  second = compartments[:second]
  index_one = 0
  index_two = 0
  match = false
  until match == true do
    if first[index_one] == second[index_two]
      match = true
      return({ matching_item: first[index_one] })
    elsif first[index_one] > second[index_two]
      index_two += 1
    elsif first[index_one] < second[index_two]
      index_one += 1
    end
  end
end

def get_badge_item(group)
  #Needs refactoring so that it maps through the hash and finds the duplicate in all key/pair values, not just the 3 that's searching for ATM.
  guide_index = (group[:elf_1] & group[:elf_2] & group[:elf_3])
  if guide_index[0] == nil
    return 0
  end
  @item_priority_guide[guide_index[0].to_sym]
end

# Getting list from file
@rucksack_list = File.open("items.txt").read.split("\n")

# Set the priorities for each item
set_item_priority_level

# Puzzle Part #1
puts "Part #1 \n"
items_priority

puts "\n"

# Puzzle Part #2
puts "Part #2 \2"
group_badge_item(3)
