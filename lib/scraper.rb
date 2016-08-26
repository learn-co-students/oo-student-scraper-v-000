require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    scraped_students = []

    doc.search(".student-card a").each do |card|
      location = card.search(".student-location").text
      name = card.search(".student-name").text
      profile_url = "./fixtures/student-site/#{card.search('@href')}"
      scraped_students << {:name => name, :location => location, :profile_url => profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    scraped_students = {}

    doc.search(".social-icon-container a").each do |icon|

      if icon.search("@href").text.include?("twitter")
        scraped_students[:twitter] = icon.search("@href").text
      elsif icon.search("@href").text.include?("github")
        scraped_students[:github] = icon.search("@href").text
      elsif icon.search("@href").text.include?("linkedin")
        scraped_students[:linkedin] = icon.search("@href").text
      else
        scraped_students[:blog] = icon.search("@href").text
      end
    end
    scraped_students[:profile_quote] = doc.search(".profile-quote").text
    scraped_students[:bio] = doc.search(".description-holder p").text

    scraped_students
  end

end

