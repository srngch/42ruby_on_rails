#!/usr/bin/ruby -w

def city_to_state(input)
	states = {
		"Oregon" => "OR",
		"Alabama" => "AL",
		"New Jersey" => "NJ",
		"Colorado" => "CO"
	}
	capitals_cities = { 
		"OR" => "Salem",
		"AL" => "Montgomery",
		"NJ" => "Trenton",
		"CO" => "Denver"
	}

	s = capitals_cities.key(input)
	if s.nil?
		puts "Unknown capital city"
	else
		puts states.key(s)
	end
end

def erehw
	if ARGV.length == 1
		city_to_state(ARGV.first)
	end
end

erehw
