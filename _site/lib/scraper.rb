require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_arr = []
    student_hash = {}
    doc = Nokogiri::HTML(open("http://students.learn.co/"))
    #binding.pry

    student_name = doc.css(".student-card").css("h4")
    #binding.pry
    student_names = doc.css(".student-card").css("h4").text
    student_location  = doc.css(".student-card").css("p").text

    student_profile = doc.css(".student-card").each{|a| a.css('a').attribute('href').value}


  (0..student_name.size).each do |i|
      student_names.each do |st_names|
      student_location.each do |st_location|
      student_profile.each do |st_profile|
    student_hash = {
      :name => st_names,
      :location => st_location,
      :profile_url => st_profile
      }


    student_arr << student_hash
      end
    end
  end
end


    end

def self.scrape_profile_page(profile_url)

  end

end

