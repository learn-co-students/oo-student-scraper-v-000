require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
   
    student_cards = doc.css("div.student-card")
    student_cards.map do |student|
       {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").first["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    
    doc.css("div.social-icon-container a").each do |social|
      links = social.attribute("href").value
      
      if links.include?("twitter")
        scraped_student[:twitter] = links
      elsif links.include?("git")
        scraped_student[:github] = links
      elsif links.include?("linkedin")
        scraped_student[:linkedin] = links
      else
        scraped_student[:blog] = links
      end
    end
    scraped_student[:profile_quote] = doc.css("div.profile-quote").text
    scraped_student[:bio] = doc.css("div.description-holder p").text
    scraped_student
  end

end

