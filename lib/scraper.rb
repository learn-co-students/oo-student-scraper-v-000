require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes = []
    
    doc = Nokogiri::HTML(open(index_url))
    
    students = doc.css("div.student-card a")
    
    students.each do |student|
      student_hash = {}
      
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = student.attribute("href").value 
      
      array_of_student_hashes << student_hash
    end
    array_of_student_hashes
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    profile = Nokogiri::HTML(open(profile_url))
    
    profile_attributes = profile.css("div.main-wrapper.profile")
    binding.pry
    
    # twitter: profile_attributes.css("div.social-icon-container a").attribute("href").value
    # social_links = profile_attributes.css("div.social-icon-container a").collect{|social_link| social_link.attribute("href").value}
    # twitter = social_links[0], linkedin = social_links[1], github = social_links[2], blog = social_links[3]
    # profile_quote = profile_attributes.css(".profile-quote").text
    # bio = profile_attributes.css(".details-container .bio-content.content-holder p").text
    
    #students.each do |student|
    #  
    #  student_attributes[:name] = students.css("h4.student-name").text
    #  student_attributes[:location] = students.css("p.student-location").text
    #  student_attributes[:profile_url] = students.attribute("href").value 
    #  
    #end
  end

end

