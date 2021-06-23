#!/usr/bin/ruby -w

def state_to_city(input)
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

	code = states[input]
	if code.nil?
		puts "Unknown state"
	else
		puts capitals_cities[code]
	end
end

def where
	if ARGV.length == 1
		state_to_city(ARGV.first)
	end
end

where
