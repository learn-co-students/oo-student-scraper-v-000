require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #responsible for scraping the index page that lists all of the students
    #return value = array of hashes with :name, :location, :profile_url
    doc = Nokogiri::HTML(open(index_url))
    # binding.pry
      # name = doc.css(".student-card").first.css(".card-text-container h4").text
      # location = doc.css(".student-card").first.css(".card-text-container p").text
      # profile_url = doc.css(".student-card").first.css("a").attribute("href").value

      scraped_students = []

      doc.css(".student-card").each do |student|
        hash = {
          :name => student.css(".card-text-container h4").text,
          :location => student.css(".card-text-container p").text,
          :profile_url => student.css("a").attribute("href").value
        }
        scraped_students << hash
      end
      scraped_students
    end

  def self.scrape_profile_page(profile_url)
    #responsible for scraping an individual student's profile page to get further information
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    # twitter url = doc.css(".social-icon-container a:nth-child(1)").attribute("href").value
    # linkedin url = doc.css(".social-icon-container a:nth-child(2)").attribute("href").value
    # github url = doc.css(".social-icon-container a:nth-child(3)").attribute("href").value
    # blog url = doc.css(".social-icon-container a:nth-child(4)").attribute("href").value
    # profile quote = doc.css(".profile-quote").text
    # bio = doc.css(".description-holder p").text
    hash = {}

    child = 1
    while child < doc.css(".social-icon-container a").length + 1
      social_link = doc.css(".social-icon-container a:nth-child(#{child})").attribute("href").value
        if social_link.include?("twitter")
          hash[:twitter] = social_link
        elsif social_link.include?("linkedin")
          hash[:linkedin] = social_link
        elsif social_link.include?("github")
          hash[:github] = social_link
        else
          hash[:blog] = social_link
        end
      child += 1
    end
      hash[:profile_quote] = doc.css(".profile-quote").text
      hash[:bio] = doc.css(".description-holder p").text
      hash
    end
end
