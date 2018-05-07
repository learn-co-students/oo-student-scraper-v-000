require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}" 
          # student_card.css(".card-text-container").each do |blurb|
            student_name = student.css(".student-name").text
            student_location = student.css(".student-location").text
            students << {name: student_name, location: student_location, profile_url: student_profile_link}
          # end
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    personal_page = {}
      
    links = profile_page.css(".social-icon-container").children.css("a").map do |x|
      x.attr('href')
      #or => x.attribute('href').value
    end
    links.each do |link|
      if link.include?("linkedin")
        personal_page[:linkedin] = link
      elsif link.include?("github")
        personal_page[:github] = link
      elsif link.include?("twitter")
        personal_page[:twitter] = link
      else
        personal_page[:blog] = link
      end
    end

    personal_page[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text   
    personal_page[:profile_quote] = profile_page.css(".profile-quote").text 

    personal_page
  end

end

