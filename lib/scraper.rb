require  'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    studnt = []
    doc = Nokogiri::HTML(open(index_url))
    scraper_doc   = doc.css(".student-card a")

  #  binding.pry
       scraper_doc.each do |student|
         studnt <<
         {
         :name =>  student.css(".student-name").text,
         :location =>  student.css(".student-location").text,
          :profile_url =>  student.attr("href")
        }
      #    puts "name                     "  + name
      #    puts  "location                "  + location
      #    puts  profile_url

#
    end
    puts studnt
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    ddddddddd  =  doc.css("div.bio-content.content-holder div.description-holder p").text
    puts ddddddddd
  # binding.pry
   student[:bio]   =   doc.css("div.bio-content.content-holder div.description-holder p").text
  student[:profile_quote] = doc.css(".profile-quote").text
   puts student
    social = doc.css(".social-icon-container a")
    social.each do |social|
      if social.include?("linkedin")
        student[:linkedin] = social
      elsif social.include?("github")
        student[:github] = social
      elsif social.include?("twitter")
        student[:twitter] = social
      else
        student[:blog] = social
      end
  #    puts "student"
  end
  puts student
end
end
#Scraper.scrape_index_page("fixtures/student-site/index.html")
Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
