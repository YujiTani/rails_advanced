messages = []

result = File.open('./tmp/result.json'){|f|
  f.each_line(rs=""){|line|
    if line.match?(/Failure:|Error:/)
      messages << line.strip
    end
  }
}

p messages
