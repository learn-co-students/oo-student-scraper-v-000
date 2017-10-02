require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    roster = []
    page = open(index_url)
    doc = Nokogiri::HTML(page)
    students = doc.css(".student-card")

    students.each do |student|
      roster << {:name => student.at(".student-name").text,
        :location => location = student.at(".student-location").text,
        :profile_url => profile_url = student.at("a").attributes['href'].value}
      end
    roster
  end

  def self.scrape_profile_page(profile_url)
    profiles = {}
    profile = open(profile_url)
    doc = Nokogiri::HTML(profile)
    social = doc.css(".social-icon-container a")
      social.each do
        |kid|  value = kid.attributes['href'].value
        case value
        when /linkedin/
         profiles[:linkedin] = value
       when /twitter/
         profiles[:twitter] = value
       when /github/
         profiles[:github] = value
       else
         profiles[:blog] = value
       end
    end

      profiles[:profile_quote] = doc.css(".profile-quote").text
      profiles[:bio] = doc.css(".description-holder p").text

    profiles
  end
end
