#!/usr/bin/ruby -w

def parse_param(str)
	arr = str.split(',')
	# arr.map!{ |a|
	# 	a.strip.downcase
	# }
	return arr
end

def state_city(arr)
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

	arr.each do |a|
		next if a.empty?
		states_downcase = states.map { |k, v| 
			[k.downcase.gsub(/\s/, ""), v]
		}.to_h
		code = states_downcase[a]
		if code.nil?
			cities_downcase = capitals_cities.map { |k, v| 
				[k, v.downcase.gsub(/\s/, "")]
			}.to_h
			code = cities_downcase.key(a)
			if code.nil?
				puts "#{a} is neither a capital city nor a state"
				next
			end
		end
		city = capitals_cities[code]
		state = states.key(code)
		puts "#{city} is the capital of #{state} (akr: #{code})"
	end
end

def whereto
	if ARGV.length == 1
		str = ARGV.first.downcase.gsub(/\s/, "")
		arr = parse_param(str)
		state_city(arr)
	end
end

whereto
