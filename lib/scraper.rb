require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    # Student name: html.css(".card-text-container h4.student-name").text
    # location: html.css(".card-text-container p.student-location").text
    # url: html.css("student-card a").attribute('href').value
    scraped_students = []

    html.css(".student-card").each do |card|
      student = {}
      student[:name] = card.css(".card-text-container h4.student-name").text
      student[:location] = card.css(".card-text-container p.student-location").text
      student[:profile_url] = card.css("a").attribute('href').value
      scraped_students << student
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))

    # .vitals-container
    # Linkedin: card.css(".social-icon-container").attribute('href').value
    # Github: card.css(".social-icon-container").attribute('href').value
    # Blog: card.css(".social-icon-container").attribute('href').value
    # Profile Quote: card.css(".profile-quote").text
    # Bio: card.css(".bio-content .description-holder").text

    scraped_student = {}
    social_links = []

    html.css(".social-icon-container a").each do |link|
      social_links << link.attribute('href').value
    end

    social_links.each do |link|
      if link.match(/github\.com/)
        scraped_student[:github] = link
      elsif link.match(/twitter\.com/)
        scraped_student[:twitter] = link
      elsif link.match(/linkedin\.com/)
        scraped_student[:linkedin] = link
      else
        scraped_student[:blog] = link
      end
    end

    scraped_student[:profile_quote] = html.css(".profile-quote").text
    scraped_student[:bio] = html.css(".bio-content .description-holder p").text

    scraped_student

  end

end
