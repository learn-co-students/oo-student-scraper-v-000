require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url)).css("div.student-card")

    profiles = []

    doc.each do |p|
      hash = {
      :name => p.css(".student-name").text,
      :location => p.css(".student-location").text,
      :profile_url => "./fixtures/student-site/" + p.css("a").attribute("href").value
      }
      profiles << hash
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}

    doc.css("div.social-icon-container a").each do |p|
      if p.attribute("href").value.include?("twitter")
        hash[:twitter] = p.attribute("href").value
      elsif p.attribute("href").value.include?("linkedin")
        hash[:linkedin] = p.attribute("href").value
      elsif p.attribute("href").value.include?("github")
        hash[:github] = p.attribute("href").value
      else
        hash[:blog] = p.attribute("href").value
      end
    end      
      hash[:profile_quote] = doc.css("div.profile-quote").text
      hash[:bio] = doc.css("div.description-holder p").text
      hash
  end

end

