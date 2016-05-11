require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    student_bio = doc.css(".student-card") #captures each student's personal bio info in a variable
    student_bio.each do |student| #each individual student HTML
      students << {:name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url =>"#{index_url}#{student.css("a").attribute("href").text}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_attributes = doc.css(".social-icon-container a")
    profile_page = {}
    student_attributes.each do |attribute|
      profile_page[:bio] = attribute.css("div.bio-content.content-holder div.description-holder p").text
      profile_page[:blog]
      profile_page[:github]
      profile_page[:linkedin]
      profile_page[:profile_quote] = attribute.css(".profile_quote").text
      profile_page[:twitter]
      binding.pry
    end
    profile_page
  end

end
