require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = [] 
    # binding.pry
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_profile_link = student.css("a").first["href"]
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end 
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    # binding.pry
    links = profile_page.css(".social-icon-container").children.css("a").map{|li| li.attribute("href").value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link 
      elsif link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      else 
        student[:blog] = link 
      end 
    end 
    
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p").text
    
    student 
  end
end

