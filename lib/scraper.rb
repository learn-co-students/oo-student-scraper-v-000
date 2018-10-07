require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    students = []
    site.css(".student-card").each do |student|
      students << {
        :name => student.css(".card-text-container h4.student-name").text,
        :location => student.css(".card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_details = {}
    
    page.css("div.vitals-container div.social-icon-container a").each do |site|
      if site.attribute("href").value.include?("twitter")
        student_details[:twitter] = site.attribute("href").value
      elsif site.attribute("href").value.include?("linkedin")
        student_details[:linkedin] = site.attribute("href").value
      elsif site.attribute("href").value.include?("github")
        student_details[:github] = site.attribute("href").value
      else
        student_details[:blog] = site.attribute("href").value
      end
    end
    student_details[:profile_quote] = page.css("div.vitals-text-container div.profile-quote").text
    student_details[:bio] = page.css("div.details-container div.description-holder p").text
    
    student_details
  end

end