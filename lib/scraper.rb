require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    page.css(".student-card").each do |student_card|
    #binding.pry
      student = {
        :name => student_card.css("h4").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    social_links = page.css("div.social-icon-container a")
    social_links.each do |social_link|
      social_link_hash = {
        :twitter => social_link.css("a").select{|link| link["href"].include?("twitter")}
        :linkedin => social_link.css("a").select{|link| link["href"].include?("linkedin")}
        :github => social_link.css("a").select{|link| link["href"].include?("github")}
      }
    end
    
      binding.pry
    end
  end
        
      
      
    #     social_links = 
    #     :twitter =>
    #     :linkedin =>
    #     :github =>
    #     :blog =>
    #     :profile_quote =>
    #     :bio =>

end

