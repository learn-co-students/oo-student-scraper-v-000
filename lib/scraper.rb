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
  # binding.pry
   student[:bio]   =   doc.css("div.bio-content.content-holder div.description-holder p").text
   links = doc.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value
    puts links
     }
    puts links

  student[:profile_quote] = doc.css(".profile-quote").text
  # puts student
    social_link = doc.css(".social-icon-container a")
    puts social_link
    ddd = []
    social_link.each do |social|
    #S   puts social
       puts " "

       ddd << social.attr("href")
       puts ddd
     end
      ddd.each do |dd|
      if dd.include?("linkedin")
        student[:linkedin] = dd
      elsif dd.include?("github")
        student[:github] = dd
      elsif dd.include?("twitter")
        student[:twitter] = dd
      else
        student[:blog] = dd
      end
  #    puts "student"
  end
  puts student
end
end
#Scraper.scrape_index_page("fixtures/student-site/index.html")
Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
