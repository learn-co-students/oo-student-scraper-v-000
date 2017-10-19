require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    arr_to_return = []

    html = open(index_url) # use open-URL to get the html
    doc = Nokogiri::HTML(html) # use nokogiri to parce out the html
    cards = doc.css(".roster-cards-container a") # create an array with each array element containing a all of a student's info (a card)
    cards.each do |a_card|
      new_hash = { }
      new_hash[:name] = a_card.css("h4.student-name").text # get student names
      new_hash[:location] = a_card.css("p.student-location").text # get student location
      new_hash[:profile_url] = a_card['href'] #get url
      arr_to_return << new_hash
    end
    arr_to_return
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    new_hash = {}
    social_links = doc.css(".social-icon-container a")
      # social_links captures the social link icons and urls, each as an array.  Run
      # through each element in the array to see if it is a twitter link, linkedin link, etc.
      # Default to blog link.
    social_links.each do |link|
      if link['href'].include?("twitter")
        new_hash[:twitter] = link['href']
      elsif link['href'].include?("linkedin")
        new_hash[:linkedin] = link['href']
      elsif link['href'].include?("github")
        new_hash[:github] = link['href']
      else
        new_hash[:blog] = link['href']
      end
    end
      # Other information to grab here:
    new_hash[:profile_quote] = doc.css(".profile-quote").text
    new_hash[:bio] = doc.css(".description-holder p").text
    new_hash
  end

end #end of class
