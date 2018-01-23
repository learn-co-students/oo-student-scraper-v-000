require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :students


  def self.scrape_index_page(index_url)
    #Set the variable doc to equal the open index_url arguement (the HTML string)
    doc = Nokogiri::HTML(open(index_url))
    #The hash where the scraped student info will go
    scraped_students = []
    #This pulls the section containing the students
    doc.css("div.roster-cards-container").each do |card|
      #This pulls the individual students
      card.css(".student-card a").each do |student|
        #These will pull the info for each indivdual student
        student_profile = "#{student.attr('href')}"
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        #Adds the data to the scraped student hash
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    #Returning the value
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    prof = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}
    prof.css(".social-icon-container a").each do |link|
      normalized_link = link.attribute("href").text
      scraped_profile[:twitter] = normalized_link if normalized_link.include?("twitter")
      scraped_profile[:linkedin] = normalized_link if normalized_link.include?("linkedin")
      scraped_profile[:github] = normalized_link if normalized_link.include?("github")
      scraped_profile[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
    end
    scraped_profile[:profile_quote] = prof.css(".profile-quote").text if prof.css(".profile-quote")
    scraped_profile[:bio] = prof.css("div.bio-content.content-holder div.description-holder p").text if prof.css("div.bio-content.content-holder div.description-holder p")

    scraped_profile
  end

end
