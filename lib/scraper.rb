require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    index_page = Nokogiri::HTML(open(index_url))
    roster = []
    student_data = index_page.css("div.roster-cards-container .student-card a")
    student_data.each do |student|
        student_profile_url = student.attribute("href").value
        student_name = student.css("div.card-text-container .student-name").children.text
        student_location = student.css("div.card-text-container .student-location").children.text
          roster << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    roster
  end

  def self.scrape_profile_page(profile_url)
    #returns hash where key/value pairs describe individual student
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    
    links = profile_page.css("div.social-icon-container").children.css("a").map{|link| link.attribute("href").value}
    # binding.pry
    links.each do |link|
      if link.include?("linkedin") 
        student[:linkedin] = link
      elsif link.include?("github") 
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link 
      else
        student[:blog] = link
      end
    student[:profile_quote] = profile_page.css("div.profile-quote").text if profile_page.css("div.profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    end
    student
  end
end

