require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :students


   def self.scrape_index_page(index_url)

     doc = Nokogiri::HTML(open(index_url))
     student_array =[]
     doc.css(".student-card").each do |card|
       student_hash = {}
       student_hash =  {
       :name => card.css(".student-name").text,
       :location => card.css(".student-location").text,
       :profile_url => card.css("a").attr('href').text
       }
       student_array << student_hash
     end
     student_array
   end




  def self.scrape_profile_page(profile_url)

   #twitter url, linkedin url, github url, blog url, profile quote, and bio
   doc = Nokogiri::HTML(open(profile_url))
profile_page_hash = {}
doc.css(".social-icon-container a").each do |link|
 if link.attr('href').include?("twitter")
   profile_page_hash[:twitter] = link.attr('href')
 elsif link.attr('href').include?("linkedin")
   profile_page_hash[:linkedin] = link.attr('href')
 elsif link.attr('href').include?("github")
   profile_page_hash[:github] = link.attr('href')
 else
  profile_page_hash[:blog] = link.attr('href')
end
end
  profile_page_hash[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
  profile_page_hash[:bio] = doc.css("div.description-holder p").text
  profile_page_hash
end

 end
