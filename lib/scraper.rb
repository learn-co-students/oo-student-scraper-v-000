require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    return_array = [] #empty array that will contain the student hashes to return at the end of the method
    doc = Nokogiri::HTML(open(index_url)) #uses open-uri to open the url, then uses Nokogiri to parse in the html which we will then use to scrape data

    doc.css(".student-card").each do |card| #iterates over each student card on the site, and gets name, location, and url
      return_array << { #pushes a hash of student data onto the array
        name: card.css(".student-name").text, #uses css to select the appropriate data
        location: card.css(".student-location").text,
        profile_url: "#{index_url}/#{card.css("a").collect{ |link| link['href'] }.join}" #ugly chained command to get the url
        }
    end

    return_array #implicitly returns the array of student hashes with data
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url)) #uses open-uri to open the url, then uses Nokogiri to parse in the html which we will then use to scrape data

    x={ #returns a hash of student data scraped from Nokogiri based on CSS selectors
      #twitter: doc.css("").text,
      #linkedin: doc.css("").text,
      #github: doc.css("").text,
      #blog: doc.css("").text,
      profile_quote: doc.css("div .profile-quote").text,
      bio: doc.css(".details-container .description-holder p").text
      }
    binding.pry
  end

end