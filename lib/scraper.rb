require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
     doc.css(".roster-cards-container").each do |card| 
      card.css("a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = student.attr("href")
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
     end
   students
 end
  

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
     student_profile = []
     doc.css(".vitals-container").each do |vital_info|
       vital_info.css(".vitals-text-container").each do |student_info|
        student_name = student_info.css("h1.profile-name").text
        student_location = student_info.css("h2.profile-location").text
        student_quote = student_info.css("div.profile-quote").text
        # student_blog = student_info.css
        # student_twitter = 
        # student_github =
        # student_linkedin = 
        # student_profile << {name: student_name, location: student_location, profile_quote: student_quote, blog: student_blog }
     end
    end
    # student_profile
   end
end
#twitter url, linkedin url, github url, blog url, profile quote, and bio
