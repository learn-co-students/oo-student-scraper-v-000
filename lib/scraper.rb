require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML (open(index_url))

    scraped_students = []

    index_page.css(".roster-cards-container").each do |cards|
      cards.css(".student-card").each do |card|
        student_hash = {}
        student_hash[:name] = card.css(".student-name").text
        student_hash[:location] = card.css(".student-location").text
        student_hash[:profile_url] = "students/#{student_hash[:name].gsub(" ","-").downcase}.html"
        scraped_students << student_hash
      end
    end

      scraped_students

  end

  def self.scrape_profile_page(profile_url) #responsible for scraping an individual student's profile page to get further information about that student.
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    links = profile_page.css(".social-icon-container").children.css("a").map { |link| link.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      elsif link.include?("twitter")
        scraped_student[:twitter] = link
      else
        scraped_student[:blog] = link
      end
    end
    scraped_student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    scraped_student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    scraped_student

  end

end
