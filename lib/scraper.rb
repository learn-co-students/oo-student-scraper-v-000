require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |profile|
      students << {:name => profile.css("h4").text,
                  :location => profile.css(".student-location").text,
                  :profile_url => profile.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profiles = {}
    doc.css("div.social-icon-container a").each do |profile|
      #binding.pry
      if profile.attribute("href").value.include?("twitter")
          profiles[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("linkedin")
          profiles[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        #binding.pry
          profiles[:github] = profile.attribute("href").value
      else
          profiles[:blog] = profile.attribute("href").value
        end
          profiles[:profile_quote] = doc.css("div.profile-quote").text
          profiles[:bio] = doc.css("div.description-holder p").text
      end
      profiles
    end


end
