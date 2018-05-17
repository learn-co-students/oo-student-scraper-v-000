require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    file_text = Nokogiri::HTML(html)
    
    student_hash_array = []
    
    file_text.css("div.student-card").each do |profile|
      student_hash = {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
      }
      student_hash_array << student_hash
    end
  student_hash_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    file_text = Nokogiri::HTML(html)
    
    @scraped_student = {}
    
    @scraped_student[:profile_quote] = file_text.css("div.profile-quote").text
    @scraped_student[:bio] = file_text.css("div.bio-content.content-holder").css("p").text
    file_text.css("div.social-icon-container").css("a").each do |link|
      if link.attribute("href").value.include?("twitter.com")
        @scraped_student[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin.com")
        @scraped_student[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github.com")
        @scraped_student[:github] = link.attribute("href").value
      else 
        @scraped_student[:blog] = link.attribute("href").value
      end
    end
    @scraped_student
  end
end

