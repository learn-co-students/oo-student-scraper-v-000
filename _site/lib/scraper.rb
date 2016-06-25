
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
#add self.back in  add (index_url) back in 
  	
  	students = []

  	doc = Nokogiri::HTML(open(index_url))
  	doc.css(".roster-cards-container").each do |card|
	  	card.css(".student-card").each do |student|
	  		student_profile = "http://127.0.0.1:4000/#{student.css("a")[0]['href']}"
	  		student_name = student.css(".student-name").text
	  		student_location = student.css(".student-location").text
	  		students << {name: student_name, location: student_location, profile_url: student_profile}
	  	end
	  end



  	#doc.css(".student-card")

 # 	binding.pry

  	#all students:  css(".student-card") 
  	#student_name:  css(".student-name").text
  	#student_loc:   css(".student-location").text
  	#student_site:  http://127.0.0.1:4000/fixtures/student-site/#{css("a")[0]['href']}

  	
  students
  end




  #def scrape_profile_page
  def self.scrape_profile_page(profile_url)
    

    student_info = {}

    #doc = Nokogiri::HTML(open("http://127.0.0.1:4000/fixtures/student-site/students/joe-burgess.html"))
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a").map { |x| x.attribute('href').value}
      links.each do |link|
        if link.include?("twitter")
          student_info[:twitter] = link
        elsif link.include?("github")
          student_info[:github] = link
        elsif link.include?("linkedin")
          student_info[:linkedin] = link
        else student_info[:blog] = link
        end

        quote = doc.css(".profile-quote").text
        student_info[:profile_quote] = quote

        bio = doc.css(".description-holder").css('p').text
        student_info[:bio] = bio
       
    end


  #attributes :
  #name - href
  #value = link

   #    binding.pry
     student_info
  end


end




#Scraper.new.scrape_profile_page

=begin
doc = Nokogiri::HTML(open("http://flatironschool.com/"))
doc.css(".grey-text")

doc.css(".grey-text").text


instructors.each do |instructor| 
  puts "Flatiron School <3 " + instructor.css("h2").text
end

div class="roster-cards-container

div class="student-card"
a href="students/ryan-johnson.html"		profile page link
	div class card-text-container
		h4 class=student-name"> Ryan Johnson</h4>
		p class="student-location:> New York, NY</p>

   card.css(".student-card").each do |student|
        student_profile = "http://127.0.0.1:4000/#{student.css("a")[0]['href']}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        students << {name: student_name, location: student_location, profile_url: student_profile}

=end