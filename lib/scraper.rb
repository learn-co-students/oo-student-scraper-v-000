require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students_array = [] 
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        name = student.css("h4.student-name").text
        location = student.css("p.student-location").text
        profile_url = "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
        students_array << {name: name, location: location, profile_url: profile_url}
      end  
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    profile_doc = Nokogiri::HTML(open(profile_url))
    attributes_hash = { 
      :profile_quote => profile_doc.css(".profile-quote").text,
      :bio => profile_doc.css(".bio-content.content-holder .description-holder p").text
    }

    profile_doc.css(".social-icon-container").each do |icon|
      icon.css("a").each do |link|
        link = link.attribute("href").value
        if link.include?("twitter")
          attributes_hash[:twitter] = link
        elsif link.include?("linkedin")
          attributes_hash[:linkedin] = link
        elsif link.include?("github")
           attributes_hash[:github] = link
        else
           attributes_hash[:blog] = link
        end  
      end
    end  
    attributes_hash    
  end

end
















 