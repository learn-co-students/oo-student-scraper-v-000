require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css(".student-card").each do |card|
      students << {
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: card.css("a").attribute("href").value
      }
    end
    # profile_url = page.css(".student-card").first.css("a").attribute("href").value
    # name = page.css(".student-card").first.css(".student-name").text
    # location = page.css(".student-card").first.css(".student-location").text
    # array of hashes in which each hash represent a single student.
    # The keys of the individual student hashes should be :name, :location and :profile_url
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    #twitter = page.css(".social-icon-container a").first.attribute("href").text,
    #linkedin = page.css(".social-icon-container a")[1].attribute("href").text,
    #github = page.css(".social-icon-container a")[2].attribute("href").text,
    #blog = page.css(".social-icon-container a")[3].attribute("href").text,

    info = {
      profile_quote: page.css(".profile-quote").text,
      bio: page.css(".bio-content .description-holder p").text
    }

    page.css(".social-icon-container a").each do |social_icon|
      image = social_icon.css("img").attribute("src").text
      url = social_icon.attribute("href").text
      case image
      when "../assets/img/twitter-icon.png"
        info[:twitter] = url
      when "../assets/img/linkedin-icon.png"
        info[:linkedin] = url
      when "../assets/img/github-icon.png"
        info[:github] = url
      when "../assets/img/rss-icon.png"
        info[:blog] = url
      end
    end
    info
  end

end
