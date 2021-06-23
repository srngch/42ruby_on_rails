#!/usr/bin/ruby -w

def coffee_croissant
	data = [
		['Frank', 33],
		['Stacy', 15],
		['Juan' , 24],
		['Dom'  , 32],
		['Steve', 24],
		['Jill' , 24]
	]

	data = data.sort_by { |k, v| 
		[v, k]
	}
	
	data.each { |k, v|
		puts k
	}
end

coffee_croissant
