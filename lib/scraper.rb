require 'open-uri'
require 'pry'

class Scraper
@@student_index = []

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
   students.css("div.student-card").each do |student|
      @@student_index<< {
                      :name => student.css("h4.student-name").text,
                      :location => student.css("p.student-location").text,
                      :profile_url => "./fixtures/student-site/" +  student.css("a").attribute("href").value
                      }
    end
    @@student_index
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
   student = {}
   student[:profile_quote] = profile.css("div.profile-quote").text
   student[:bio] = profile.css("div.description-holder p").text
   social_link = profile.css(".social-icon-container a").collect { |outlet| outlet["href"] }
   social_link.each do |outlet|

     if outlet.include?("github")
       student[:github] = outlet
     elsif outlet.include?("facebook")
       student[:facebook] = outlet
     elsif outlet.include?("linkedin")
       student[:linkedin] = outlet
     elsif outlet.include?("twitter")
       student[:twitter] = outlet
     else
       student[:blog] = outlet
     end
   end
   student[:profile_quote] = profile.css("div.profile-quote").text
   student[:bio] = profile.css("div.description-holder p").text if profile.css("div.description-holder p")
   student
  end

end
