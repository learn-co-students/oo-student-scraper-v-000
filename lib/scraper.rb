require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_data_list = doc.css("div.roster-cards-container div.student-card")
    
    students = [] 
    
    student_data_list.each do |student|
      students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end 
    
    students 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    student_data = doc.css("div.social-icon-container")
    student_quote = doc.css("div.profile-quote")
    student_bio_data = doc.css("div.details-container div.description-holder p")
    
    student_data.css("a").each do |profile|
      if profile.attribute("href").value.include?("twitter")
        student[:twitter] = profile.attribute("href").value 
      elsif profile.attribute("href").value.include?("linkedin")
        student[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        student[:github] = profile.attribute("href").value 
      else
        student[:blog] = profile.attribute("href").value 
      end 
    end 
    
    student[:profile_quote] = student_quote.text if student_quote.text
    student[:bio] = student_bio_data.text if student_bio_data.text
    student 
  end

end