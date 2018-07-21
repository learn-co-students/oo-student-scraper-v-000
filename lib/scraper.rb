require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_data = doc.css(".roster-cards-container")

    student = {}
    student_data.css("h4.student-name").each do |student|
      student_names[:name] = student.text
      binding.pry
    end
    student_locations = []
    student_data.css("p.student-location").each do |student|
      student_locations << student.text
    end
    student_urls = []
    student_data.css(".student-card a").each do |student|
      student_urls << student.attribute("href").value

    end

  #end
    #student_profiles = student_data.css(".student-card")
    #student_urls = student_profiles.css("a").attribute("href").value


    #doc.css("div.student-card").each do |student|
    #doc.css("a href").value
    #end

      #:name => student.css("h4.student-name").text,


    #doc.css("a href").value
    #end
    #student_profiles = student_data.css("a").attribute("href")






    #locations = doc.css("p.student-location").first.text
    #doc.css("div.student-card")
  end


  def self.scrape_profile_page(profile_url)

  end

end
