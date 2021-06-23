#!/usr/bin/ruby -w

def croissant
	f = File.open("numbers.txt").read
	arr = []

	f.each_line do |line|
		arr.push(line.gsub(/[,\r\n]/, "").to_i)
		puts line
	end

	arr2 = arr.sort
	arr2.each do |n|
		puts n
	end
end

croissant
