require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card").collect do |student|
      {
        :name => student.search("h4.student-name")[0].text,
        :location => student.search("p.student-location")[0].text,
        :profile_url => student.search("a")[0]["href"]
      }
    end 
  end

  def self.scrape_profile_page(profile_url)
    student_doc = Nokogiri::HTML(open(profile_url))
    
    links = student_doc.css("div.social-icon-container a")
    array_of_links = links.collect{|link| link['href']}
    
    profile = {}
    array_of_links.each do |social|
      profile[:twitter] = social if social.include?("twitter")
      profile[:linkedin] = social if social.include?("linkedin")
      profile[:github] = social if social.include?("github")
      profile[:blog] = social if !profile.has_value?(social) #!profile.include?(social)
    end 
    
    profile[:profile_quote] = student_doc.css("div.profile-quote").text
    profile[:bio] = student_doc.css("div.description-holder p").text
    
    profile 
    
  end 

# all_social = student_doc.css("div.social-icon-container")
# social = social.css("a")[3]["href"]
# profiel_quote = student_doc.css("div.profile-quote").text
# bio = student_doc.css("div.description-holder p").text
#links = student_doc.css("div.social-icon-container a")
# links.collect{|link| link['href']}


end

