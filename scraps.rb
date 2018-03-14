

y=cards.css("h4.student-name")

y[0].text == "name"

-----

playing with .send -- all typed in irb


class Boy
end

tim = Boy.new

def tim.add_two(arg)
  puts "#{arg + 2}"
end

tim.send("add_two", 8)
=> 10

***TN: note how calling the method with .send (the first arg) has to be in quotes
