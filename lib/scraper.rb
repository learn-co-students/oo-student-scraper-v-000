require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url.to_s)
    index = Nokogiri::HTML(html)

     cards = []

    index.css(".roster-cards-container").each do |roster|
      cards = roster.css(".student-card").collect do |card|
          {
            :name => card.css("h4.student-name").text,
            :location => card.css("p.student-location").text,
            :profile_url => card.css("a").attribute("href").value
          }
      end
    end
    cards
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url.to_s)
    index = Nokogiri::HTML(html)

    cards = {}
    social = []


     social = index.css("a").collect do |card|
             card.attribute("href").value
     end


     social.each do |icon|
       if icon.include?("twitter")
         cards[:twitter] = icon
       elsif icon.include?("linkedin")
         cards[:linkedin] = icon
       elsif icon.include?("github")
         cards[:github] = icon
      elsif icon.include?(".com") && !icon.include?("twitter") &&
            !icon.include?("github") && !icon.include?("linkedin") then
       cards[:blog] = icon
     end
   end

  index.css(".vitals-text-container").collect do |card|
      cards[:profile_quote] = card.css(".profile-quote").text.strip
  end

  cards[:bio] = index.css(".description-holder p").text.strip

  cards

  end

end
