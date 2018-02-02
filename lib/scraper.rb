require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    
    doc.css("div.student-card").each do |card|
      student_hash = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value,
      }
      student_array << student_hash
    end  
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_page = {}
    
    doc.css(".social-icon-container a").each do |x| 
      link = x.attr("href")
      case
      when link.include?("twitter")
        profile_page[:twitter] = link
      when link.include?("linkedin")
        profile_page[:linkedin] = link
      when link.include?("github")
        profile_page[:github] = link  
      else
        profile_page[:blog] = link
      end
    end
    profile_page[:bio] = doc.css(".description-holder p").text
    profile_page[:profile_quote] = doc.css(".profile-quote").text
    profile_page
  end

end

