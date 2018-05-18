require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = doc.css("div.student-card")

    scraped_students.map do |x|
      {
        :name => x.css('h4').text,
        :location => x.css('p').text,
        :profile_url => x.css('a').attribute('href').value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)

    scraped = {}
    social = []

    doc.css('div.social-icon-container a').each {|link|
      social << link
    }

    social.each do |x|
      if x.attribute('href').value.include? "twitter"
        scraped[:twitter] = x.attribute('href').value
      elsif x.attribute('href').value.include? "linkedin"
        scraped[:linkedin] = x.attribute('href').value
      elsif x.attribute('href').value.include? "github"
        scraped[:github] = x.attribute('href').value
      else
        scraped[:blog] = x.attribute('href').value
      end
  end
  scraped[:profile_quote] = doc.css('div.profile-quote').text
  scraped[:bio] = doc.css('div.description-holder p').text
  scraped
end
end
