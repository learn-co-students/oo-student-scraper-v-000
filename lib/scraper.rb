require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".roster-cards-container").each do | student_card |
      student_card.css(".student-card a").each do | student |
        student_array << { name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.attribute("href").value }
      end
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open(profile_url))
    student = {}
    
    student_page.css(".vitals-container .social-icon-container a").each do | social |
      
      if social.attribute("href").value.include?("twitter")
        student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student[:github] = social.attribute("href").value
      else
        student[:blog] = social.attribute("href").value
      end
    end
    student[:profile_quote] = student_page.css(".vitals-container .vitals-text-container .profile-quote").text
    student[:bio] = student_page.css(".details-container .description-holder").css("p").text
    
    student
  end
end