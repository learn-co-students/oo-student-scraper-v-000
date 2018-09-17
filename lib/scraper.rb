require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
  
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attr("href")
      }
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = []
    doc.css("div.social-icon-container").children.css("a").collect do |element| 
      social_links << element.attribute("href").value
    end
    social_links.each do |link|
      if link.include?("twitter.com")
        student_profile[:twitter] = link
      elsif link.include?("linkedin.com")
        student_profile[:linkedin] = link
      elsif link.include?("github.com")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = doc.css("div.vitals-text-container div").text
    student_profile[:bio] = doc.css(" div.description-holder p").text
    student_profile
  end

end

