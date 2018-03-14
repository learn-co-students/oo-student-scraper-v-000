require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) #responsible for scraping the index page that lists all of the students
    #return an array of hashes in which each hash represents one student.
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []

    doc.css(".student-card").each do |student_card|
      name = student_card.css(".student-name").text
      location = student_card.css(".student-location").text
      profile_url = student_card.css("a").first["href"]
      student_hash = {:name => name, :location => location, :profile_url => profile_url}
      student_index_array << student_hash
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}
    attributes = doc.css(".social-icon-container")
    profile_quote_attribute = doc.css(".profile-quote")
    profile_bio = doc.css(".description-holder").first.css("p").text

    attributes.css("a").each do |attribute|
      attribute_url = attribute["href"] #www.twitter.com...
      attribute_name = attribute_url.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/, '') #twitter
      if attribute_name == "twitter" || attribute_name == "linkedin" || attribute_name == "github"
        attribute_symbol = attribute_name.to_sym
        scraped_profile[attribute_symbol] = attribute_url
      else
        scraped_profile[:blog] = attribute_url
      end
    end

    if profile_quote_attribute != nil
      scraped_profile[:profile_quote] = profile_quote_attribute.text
    end

    if profile_bio != nil
      scraped_profile[:bio] = profile_bio
    end

    scraped_profile
  end
end
