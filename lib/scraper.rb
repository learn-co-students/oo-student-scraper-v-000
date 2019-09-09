require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    
    index_doc.css('div.student-card').each do |student|
      scraped_students.push(name: student.css('h4.student-name').text, 
      location: student.css('p.student-location').text, 
      profile_url: student.css('a').attribute('href').value)
    end
    scraped_students
  end
  
  def self.scrape_profile_page(profile_url)
    student_profile = {}
    profile = Nokogiri::HTML(open(profile_url))

    social = profile.css(".social-icon-container a")
    social.each do |icon|
      icon = icon.attribute("href").value 
      if icon.include?("twitter")
        student_profile[:twitter] = icon
      elsif icon.include?("linkedin")
       student_profile[:linkedin] = icon 
      elsif icon.include?("github")
       student_profile[:github] = icon
      else
       student_profile[:blog] = icon
      end
    end
     
    student_profile[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student_profile[:bio] = profile.css(".description-holder p").text
    
    student_profile
  end
    
end

