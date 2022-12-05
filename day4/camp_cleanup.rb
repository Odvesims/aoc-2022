require 'set'

def overlapping_sections
  sections = File.open("assigned-sections.txt").read.split("\n")
  total_overlapping_sections = 0
  sections.each_with_index do |section, i|
    part_one = Range.new(section.split(",")[0].split("-")[0], section.split(",")[0].split("-")[1])
    part_two = Range.new(section.split(",")[1].split("-")[0], section.split(",")[1].split("-")[1])
    set_one = Set.new(part_one)
    set_two = Set.new(part_two)
    if set_one >= set_two or set_two >= set_one
      total_overlapping_sections += 1
    end
  end
  puts total_overlapping_sections
end

#Puzzle's Part #1

overlapping_sections