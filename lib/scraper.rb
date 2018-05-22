require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   learn_ver = Nokogiri::HTML(open(index_url)) 
   
   students = []
   
     learn_ver.css("div.student-card").each do |student|
       student_hash = {}
       student_hash = {
        :name => student.css("div.card-text-container h4").text,
        :location =>student.css("div.card-text-container p").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << student_hash
    end
   students
  end

  def self.scrape_profile_page(profile_url)
    student_prof = Nokogiri::HTML(open(profile_url))
    binding.pry
  end

end

