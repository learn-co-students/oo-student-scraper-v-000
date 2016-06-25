require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  @url = "http://127.0.0.1:4000/"
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    scraped_students = Nokogiri::HTML(open(index_url))
    scraped_students.css(".student-card").collect do |student|
      {name: student.css("h4").text,
      location: student.css("p").text,
      profile_url: @url + student.css("a").attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    scraped_student = Nokogiri::HTML(open(profile_url))
#binding.pry
      scraped_student.css("div.social-icon-container a").each do |social|

        if social.attribute("href").value.include?("twitter")
          hash[:twitter] = social.attribute("href").value
        elsif social.attribute("href").value.include?("linkedin")
          hash[:linkedin] = social.attribute("href").value
        elsif social.attribute("href").value.include?("git")
          hash[:github] = social.attribute("href").value
        else
          hash[:blog] = social.attribute("href").value
        end
    hash[:profile_quote] = scraped_student.css("div.profile-quote").text
    hash[:bio] = scraped_student.css("div.description-holder p").text

    end
    hash
  end

end
