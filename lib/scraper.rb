require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #setup to open the URL
    Nokogiri::HTML(open("http://students.learn.co/"))
    doc = Nokogiri::HTML(open("http://students.learn.co/"))
    students = []
    student = doc.css("div.roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: profile_url}
      end
    end
      students
end

def self.scrape_profile_page(index_url)
  #setup to open the URL
  Nokogiri::HTML(open(index_url))
  doc = Nokogiri::HTML(open(index_url))
  student = {}
  links = doc.css(".social-icon-container").children.css("a").collect {|profile| profile.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
         elsif link.include?("github")
           student[:github] = link
         elsif link.include?("twitter")
           student[:twitter] = link
         else
           student[:blog] = link
       end
     end
     student[:profile_quote] = doc.css(".profile-quote").text
     student[:bio] = doc.css(".bio-content div.description-holder p").text

    student
end
end # Ends the class
