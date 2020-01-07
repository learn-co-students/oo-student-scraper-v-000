students = doc.css(".student-card a") #- will pull down info i need
students.collect do |student|
  "#{student.css(".student-name").text}: #{student.css(".student-location").text}: .fixtures/student-site/#{student["href"]}"
end

student_array = students.collect {|student| "#{student.css(".student-name").text}: #{student.css(".student-location").text}: .fixtures/student-site/#{student["href"]}"}
refined_student_array = student_array.collect {|student| student.split(":").collect {|element| element.to_s.strip}}
refined_student_array.collect do |name, location, profile_url|
  @student_info = {:name => nil, :location => nil, :profile_url => nil}
  @student_info[:name] = name
  @student_info[:location] = location
  @student_info[:profile_url] = profile_url
  @student_info
end

social.find{|element| element.include?("twitter")
  returns => "https://twitter.com/jmburges"

@profile_info[:twitter] = social.find{|element| element.include?("twitter")}

social.find do |element|
  if element.include?("linkedin") == false && element.include?("twitter") == false && element.include?("github") == false
    @profile_info[:blog] = element
  else
    false
  end
end
@profile_info[:quote] =

profile.css(".profile-quote").text.delete('\\"')
profile.css("p").text
input

if social.find{|element| element.include?("twitter")}
  @profile_info[:twitter] = social.find{|element| element.include?("twitter")}
else
  false
end

if social.find{|element| element.include?("linkedin")}
  @profile_info[:linkedin] = social.find{|element| element.include?("linkedin")}
else
  false
end

if social.find{|element| element.include?("github")}
  @profile_info[:github] = social.find{|element| element.include?("github")}
else
  false
end

students_array.each {|element| self.new(element)}
attributes_hash.each {|key,value| self.send(("#{key}="),value)}
social.find do |element|
  if element.include?("twitter")}
    @profile_info[:twitter] = social.find{|element| element.include?("twitter")}
  elsif element.include?("linkedin")}
    @profile_info[:linkedin] = social.find{|element| element.include?("linkedin")}
  elsif element.include?("github")}
    @profile_info[:github] = social.find{|element| element.include?("github")}
  # elsif element.include?("linkedin") == false && element.include?("twitter") == false && element.include?("github") == false
  #   @profile_info[:blog] = element
  else
    false
  end
end
