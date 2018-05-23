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

    
    student_hash_2 = {}
    
        #student_hash_2[:twitter] = ""
        #student_hash_2[:linkedin] = ""
        #student_hash_2[:github] = ""
        #student_hash_2[:blog] = ""
    
      student_prof.css("div.social-icon-container").css("a").each do |s_icon|
       
       temp = s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"")
    
      
        if temp == "twitter"
          student_hash_2[:twitter] = s_icon.attribute("href").value if s_icon.attribute("href").value
        
        elsif temp == "linkedin"
          student_hash_2[:linkedin] = s_icon.attribute("href").value if s_icon.attribute("href").value
        
        elsif temp == "github"
          student_hash_2[:github] = s_icon.attribute("href").value if s_icon.attribute("href").value
        
        else 
          student_hash_2[:blog] = s_icon.attribute("href").value if s_icon.attribute("href").value
        end
      
      end
    
    
        
        student_hash_2[:profile_quote] = student_prof.css("div.profile-quote").text
        
        student_hash_2[:bio] = student_prof.css("div.bio-content p").text
    
        #binding.pry
      
      student_hash_2
    
      
      
  end

end

