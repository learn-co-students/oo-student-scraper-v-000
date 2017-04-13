require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css('div.student-card')
    array = cards.collect do |card|
      hash = {name: card.css('h4.student-name').text, location: card.css('p.student-location').text, profile_url: card.at('a')['href']}
    end
  end

  def self.scrape_profile_page(profile_url)
    @hash = {}
    links = []
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css('div.social-icon-container a')
    social.collect do |a|
      link = a['href']
      sym = ""
      if link.include?("twitter")
        sym = :twitter
      elsif link.include?("github")
        sym = :github
      elsif link.include?("linkedin")
        sym = :linkedin
      else
        sym = :blog
      end
      hash = {sym => link}
      @hash.merge!(hash)
    end
    quote = doc.css('.profile-quote')
    bio = doc.css('div.bio-content.content-holder div.description-holder p')
    hash1 = {:profile_quote => quote.text, :bio => bio.text}
     #binding.pry
    @hash.merge!(hash1)
    @hash
#binding.pry
  end
#  binding.pry
end
