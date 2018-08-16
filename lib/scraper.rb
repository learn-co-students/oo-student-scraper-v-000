require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
  
    doc.css(".student-card").collect do |card|
       scraped_students = {
        :name => card.css("h4.student-name").text, 
        :location => card.css("p.student-location").text, 
        :profile_url => card.css("a").attribute("href").value
      }
    end 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
  
     scraped_student = {}
       doc.css(".social-icon-container a").each do |social_link|
        link = social_link.attribute("href").value
        if link.include?("twitter")
          scraped_student[:twitter] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] =  link
        elsif link.include?("github")
          scraped_student[:github] = link
        else 
          scraped_student[:blog] = link
        end
      end
      scraped_student[:profile_quote] = doc.css(".profile-quote").text
      scraped_student[:bio] = doc.css(".bio-block p").text
      scraped_student 
    end
end
