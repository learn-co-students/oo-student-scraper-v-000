require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
   	  student = {}
    	student[:name] = card.css("h4.student-name").text
   	  student[:location] = card.css("p.student-location").text
    	student[:profile_url] = "./fixtures/student-site/" + card.css("a").attribute("href").value
    	students.push(student)
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    #twitter = page.css(".social-icon-container a")[0].attribute("href").text,
    #linkedin = page.css(".social-icon-container a")[1].attribute("href").text,
    #github = page.css(".social-icon-container a")[2].attribute("href").text,
    #blog = page.css(".social-icon-container a")[3].attribute("href").text,

    info = {
      profile_quote: profile.css(".profile-quote").text,
      bio: profile.css(".bio-content .description-holder p").text
    }

    profile.css(".social-icon-container a").each do |social_icon|
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

# Scraper.new.scrape_index_page
