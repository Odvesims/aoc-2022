require 'set'

def overlapping_sections
  sections = File.open("assigned-sections.txt").read.split("\n")

  #Part 1
  total_overlapping_sections = 0

  sections.each_with_index do |section, i|
    sets = get_sets(section)
    set_one = sets[0]
    set_two = sets[1]
    if set_one >= set_two or set_two >= set_one
      total_overlapping_sections += 1
    end
  end
  puts "Part 1: \n#{total_overlapping_sections}"

  #Part 2
  total_overlapping_sections = 0

  sections.each do |section|
    sets = get_sets(section)
    set_one = sets[0]
    set_two = sets[1]
    if (set_one & set_two).count > 0
      total_overlapping_sections += 1
    end
  end
  puts "\nPart 2: \n#{total_overlapping_sections}"
end

def get_sets(section)
  part_one = Range.new(section.split(",")[0].split("-")[0], section.split(",")[0].split("-")[1])
  part_two = Range.new(section.split(",")[1].split("-")[0], section.split(",")[1].split("-")[1])
  [Set.new(part_one), Set.new(part_two) ]
end

#Day 4 Puzzles

overlapping_sections