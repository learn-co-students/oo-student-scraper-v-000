require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
# is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
    index = Nokogiri::HTML(open(index_url))
    scraped_students = []
    cards = index.css("div.roster-cards-container div.student-card")

    cards.map do |card|
      scraped_students << {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
      end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
# is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
# can handle profile pages without all of the social links

    profile = Nokogiri::HTML(open(profile_url))
    attributes = {}

    profile.css("div.social-icon-container a").each do |xml|
      case xml.attribute("href").value
      when /twitter/
        attributes[:twitter] = xml.css("href").value
      when /linkedin/
        attributes[:linkedin] = xml.css("href").value
      when /github/
        attributes[:github] = xml.css("href").value
      else /blog/
        attributes[:blog] = xml.css("href").value
      end
      attributes[:profile_quote] = profile.css("div.vitals-text-container div.profile-quote").text
      attributes[:bio] = profile.css("div.details-container div.bio-block details-block div.bio-content content-holder div.title-holder div.description-holder p").text
    end
    attributes
  end
end
