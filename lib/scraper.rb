require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes = []
    
    doc = Nokogiri::HTML(open(index_url))
    
    students = doc.css(".student-card a")
    
    students.each do |student|
      student_hash = {}
      
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.attribute("href").value 
      
      array_of_student_hashes << student_hash
    end
    array_of_student_hashes
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    profile = Nokogiri::HTML(open(profile_url)).css(".main-wrapper.profile")
    
    weblink_nodes = profile.css(".social-icon-container a")
    weblinks = weblink_nodes.collect{|node| node.attribute("href").value}
    
    weblinks.each do |weblink|
      if weblink.match(/twitter/)
        profile_hash[:twitter] = weblink
      elsif weblink.match(/linkedin/)
        profile_hash[:linkedin] = weblink
      elsif weblink.match(/github/)
        profile_hash[:github] = weblink
      elsif weblink.match(/http:/)
        profile_hash[:blog] = weblink
      end
    end
    
    profile_hash[:profile_quote] = profile.css(".profile-quote").text
    profile_hash[:bio] = profile.css(".bio-content.content-holder p").text
    
    profile_hash
  end

end

