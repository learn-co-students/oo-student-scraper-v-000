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
    #student_prof.css("div.social-icon-container a").attribute("href").value -- gives us "https://twitter.com/jmburges"
    # student_prof.css("div.social-icon-container").css("a")    .attribute("href").value
    
    #student_prof.css("div.social-icon-container a").attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"")
    
    #student_prof.css("div.social-icon-container").css("a").each do |s_icon|
    #s_icon.attribute("href").value #link
    #s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"") #title to symbol
      
      
    #end
    
    
    
    binding.pry
  end

end

