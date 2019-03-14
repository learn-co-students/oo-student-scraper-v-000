
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


 #Is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash representsone student 
 
 
  def self.scrape_index_page(index_url) 
    students = [] 
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student|
      student_details = {} 
      
      student_details[:name] = student.css("h4.student-name").text  
        #<h4 class="student-name">Ryan Johnson</h4>
      
      student_details[:location] = student.css("p.student-location").text 
        #<p class="student-location">New York, NY</p>
        
        #<a href="students/ryan-johnson.html">
        profile_path = student.css("a").attribute("href").value
        student_details[:profile_url] = './fixtures/student-site/' + profile_path
        students << student_details 
      end 
       students 
  end


  #is a class method that scrapes a student's profile page and returns a hash of #attributes describing an individual student
    #can handle profile pages without all of the social links

  def self.scrape_profile_page(profile_url)
    student_profile = {}   #hash
    html = open(profile_url)    
    profile = Nokogiri:: HTML(html)
    
     profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end
    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile   #hash 
  end
end




