array = []

result = File.open('./tmp/result.json'){|f|
  f.each_line(rs=""){|line|
    if line.match?(/Failure:|Error:/)
      array << line.strip
    end
  }
}

puts array.size
