#!/usr/bin/ruby -w

def parse_file
	f = File.open("periodic_table.txt").read
	elms_str = []
	f.each_line do |line|
		elms_str.push(line)
	end
	elms = []
	elms_str.each do |e|
		elm = {}
		elm["name"] = e.split("=").first.strip
		e = e.split("=")[1].strip
		elm["position"] = e.split(",")[0].split(":")[1].strip.to_i
		elm["number"] = e.split(",")[1].split(":")[1].strip.to_i
		elm["small"] = e.split(",")[2].split(":")[1].strip
		elm["molar"] = e.split(",")[3].split(":")[1].strip.to_f
		electrons_str = e.split(",")[4].split(":")[1].strip
		elm["electrons"] = electrons_str.split(" ").map(&:to_i)
		elms.push(elm)
	end
	return elms
end

def write_elm_td_tag(f, elms, index)
	f.puts "<td class=\"elm\" data-number=\"#{elms[index]["number"]}\">"
	f.puts "<h4>#{elms[index]["name"]}</h4>"
	f.puts '<ul>'
	f.puts "<li>No #{elms[index]["number"]}</li>"
	f.puts "<li>#{elms[index]["small"]}</li>"
	f.puts "<li>#{elms[index]["molar"]}</li>"
	f.puts "<li>#{elms[index]["electrons"].join(' ')} electron</li>"
	f.puts '</ul>'
	f.puts '</td>'
end

def write_empty_td_tag(f)
	f.puts '<td class="empty">'
	f.puts '</td>'
end

def make_file_html(elms)
	fileHtml = File.new("periodic_table.html", "w+")
	fileHtml.puts '<!DOCTYPE html>'
	fileHtml.puts '<html lang="en">'
	fileHtml.puts '<head>'
	fileHtml.puts '<title>Periodic Table</title>'
	fileHtml.puts '<meta charset="utf-8">'
	fileHtml.puts '<link rel="stylesheet" href="periodic_table.css">'
	fileHtml.puts '</head>'
	fileHtml.puts '<body><main><table>'
	i = 0
	(0..6).each { |r| 
		fileHtml.puts '<tr>'
		(0..17).each { |c|
			if elms[i]["position"] == c
				write_elm_td_tag(fileHtml, elms, i)
				i += 1
			else
				write_empty_td_tag(fileHtml)
			end
		}
		fileHtml.puts '</tr>'
	}
	fileHtml.puts '</table></main></body>'
	fileHtml.puts '</html>'
	fileHtml.close()
end

def write_td_style(f, nums, color)
	nums.each { |n|
		if n.equal?(nums.last)
			f.print "td[data-number='#{n}'] "
		else
			f.print "td[data-number='#{n}'], "
		end
	}
	f.puts "{ background-color: #{color}; }"
end

def make_file_css
	fileCss = File.new("periodic_table.css", "w+")
	fileCss.puts 'body { margin: 0; color: #171717; font-size: 16px; }'
	fileCss.puts 'table { border-spacing: 5px; border-color: transparent; }'
	fileCss.puts 'td { width: 150px; height: 150px; min-width: 150px; max-height: 150px; padding: 10px; font-size: 0.8rem; border: 2px solid #171717; vertical-align: top; background-color: #ffc1c1; }'
	write_td_style(fileCss, [1, 6, 7, 8, 15, 16, 34], "#a1ffa2")
	write_td_style(fileCss, [2, 10, 18, 36, 54, 86, 118], "#c1feff")
	write_td_style(fileCss, [3, 11, 19, 37, 55, 87], "#fe9e9e")
	write_td_style(fileCss, [4, 12, 20, 38, 56, 88], "#ffdfae")
	write_td_style(fileCss, [5, 14, 32, 33, 51, 52, 84], "#cccd9a")
	write_td_style(fileCss, [9, 17, 35, 53, 85, 117], "#ffff9b")
	write_td_style(fileCss, [13, 31, 49, 50, 81, 82, 83, 113, 114, 115, 116], "#cdcdcd")
	fileCss.puts 'td.empty { border: none; background-color: transparent; }'
	fileCss.puts 'h4 { font-family: monospace; font-size: 1.2rem; }'
	fileCss.puts 'ul { list-style: none; padding: 0; }'
	fileCss.close()
end

def elm
	elms_arr = parse_file()
	make_file_html(elms_arr)
	make_file_css()
end

elm
