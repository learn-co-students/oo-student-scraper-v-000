require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
     doc = Nokogiri::HTML(open(index_url))
     doc.css(".roster-cards-container").each do |card|
       card.css(".student-card").each do |student|
         student_name = student.css(".student-name").text
         student_location = student.css(".student-location").text
         student_profile = student.css("a").attribute("href").text

         students << {:name => student_name, :location => student_location, :profile_url => student_profile}
       end
     end
     students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
     profile = Nokogiri::HTML(open(profile_url))

     profile.css(".social-icon-container a").each do |social|
       link = social.attribute("href").value
       if link.include?("twitter")
         student[:twitter] = link
       elsif link.include?("linkedin")
         student[:linkedin] = link
       elsif link.include?("github")
         student[:github] = link
       else
         student[:blog] = link
       end
     end

     student[:profile_quote] = profile.css(".profile-quote").text
     student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text

     student
  end

end
