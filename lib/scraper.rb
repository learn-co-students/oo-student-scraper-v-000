require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      scraped_students = {
        :name => student.css(".card-text-container").first.css("h4").text,
        :location => student.css(".card-text-container").first.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
        students << scraped_students
    end
        students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_profiles = {}
    doc.css("div.social-icon-container a").each do |profile|
      if profile.attribute("href").value.include?("twitter")
        scraped_profiles[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("linkedin")
        scraped_profiles[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        scraped_profiles[:github] = profile.attribute("href").value
      else
        scraped_profiles[:blog] = profile.attribute("href").value
      end
      scraped_profiles[:profile_quote] = doc.css("div.profile-quote").text
      scraped_profiles[:bio] = doc.css("div.description-holder p").text
    end
    scraped_profiles
  end


end
