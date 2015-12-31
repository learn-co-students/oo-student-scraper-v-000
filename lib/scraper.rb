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
    return_hash = {}

    links = doc.css("div.social-icon-container a").collect{ |link| link['href'] } #collects all the links in the social-icon-container div
    links.each do |link| #iterates through the collected links
      if link.include?("twitter") #checks if the link is twitter
        return_hash[:twitter] = link
      elsif link.include?("linkedin") #checks if the link is linkedin
        return_hash[:linkedin] = link
      elsif link.include?("github") #checks if the link is github
        return_hash[:github] = link
      else #if it's not any of the others, it must be the blog link
        return_hash[:blog] = link
      end
    end

    return_hash[:profile_quote] = doc.css("div .profile-quote").text
    return_hash[:bio] = doc.css(".details-container .description-holder p").text

    return_hash
  end

end