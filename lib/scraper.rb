require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url) #responsible for scraping the index page that lists all students
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container div.student-card").each do |student_card|
      student = {}
      student[:name] = student_card.css("h4.student-name").text
      student[:location] = student_card.css("p.student-location").text
      student[:profile_url] = student_card.css('a').attr("href").value

      students << student
    end
    students
  end


  def self.scrape_profile_page(profile_url) #scrapes individual student's profile pg to get more students info
    index_page = Nokogiri::HTML(open(profile_url))

    scraped_student = {}
    social_links = index_page.css("div.social-icon-container a").collect { |a| a.attr("href")}

    social_links.each do |link|
      if link.include?("twitter")
        scraped_student[:twitter] = link
      elsif link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      elsif link.include?("instagram")
        scraped_student[:instagram] = link
      elsif link.include?("facebook")
        scraped_student[:facebook] = link
      else scraped_student[:blog] = link
      end
    end

      scraped_student[:profile_quote] = index_page.css(".profile-quote").text
      scraped_student[:bio] = index_page.css("p").text
      scraped_student
      #binding.pry
    end

end
