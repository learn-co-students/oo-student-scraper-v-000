require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = {}
    @scrapped_students = []
      index_page.css(".roster-cards-container .student-card").each_with_index do |student, index|
        @scrapped_students[index] = {
          :name => student.css("h4").text,
          :location => student.css("p").text,
          :profile_url => student.css("a").attribute("href").value
          }
      end
    @scrapped_students
  end

  def self.scrape_profile_page(profile_url)
    
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_links={}
      profile_page.css(".social-icon-container").children.css("a").each do |link|
        if link.attribute("href").value.include?("twitter")
          profile_links[:twitter] = link.attribute("href").value
        elsif link.attribute("href").value.include?("linkedin")
          profile_links[:linkedin] = link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
          profile_links[:github] = link.attribute("href").value
        else 
          profile_links[:blog] = link.attribute("href").value
        end 
      end 
    profile_links[:profile_quote] = profile_page.css(".profile-quote").text.strip
    profile_links[:bio] = profile_page.css(".description-holder p").text.strip
    profile_links
  end
  
end

