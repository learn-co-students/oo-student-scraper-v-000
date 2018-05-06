require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_info = doc.css("div.student-card")
    Array.new.tap do |student_index|
      student_info.each do |student|
        name = student.css("h4.student-name").text
        location = student.css("p.student-location").text
        url = student.css("a").attribute("href").value
        student_index << {name: name, location: location, profile_url: url}
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css("div.social-icon-container")
    Hash.new.tap do |student_profile|
      links.css("a").each do |link| 
        value = link.attribute('href').value
        if value.include?("twitter")
          student_profile[:twitter] = value 
        elsif value.include?("linkedin")
          student_profile[:linkedin] = value 
        elsif value.include?("github")
          student_profile[:github] = value 
        else 
          student_profile[:blog] = value 
        end
      end 
      student_profile[:profile_quote] = doc.css("div.profile-quote").text 
      student_profile[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    end
  end

end
