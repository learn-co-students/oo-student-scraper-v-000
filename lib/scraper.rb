require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_list = doc.css(".student-card")
    student_list.each do |student|
      student_hash = {}
        student_hash[:name] = student.css("h4").text
        student_hash[:location] = student.css("p").text
        #:profile_url = student.css("a").text

      student_array << student_hash
    end
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
