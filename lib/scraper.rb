require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   learn_ver = Nokogiri::HTML(open(index_url)) 
   
   students = []
   
     learn_ver.css("div.student-card").each do |student|
       student_hash = {}
       student_hash ={
        :name => 
        :location =>
        :profile_url => 
      }
      students << student_hash
    end
   students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

