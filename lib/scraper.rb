require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css('div.student-card').collect do |card|
      {name: card.css('h4.student-name').text,
      location: card.css('p.student-location').text,
      profile_url: card.css('a').attribute('href').value}
    end
  end

  def self.scrape_profile_page(profile_url)
    #binding.pry
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    hash = {}
    hash[:twitter] = doc.css('a[href*="twitter"]').attribute('href').value unless doc.css('a[href*="twitter"]') == []
    hash[:linkedin] = doc.css('a[href*="linkedin"]').attribute('href').value unless doc.css('a[href*="linkedin"]') == []
    hash[:github] = doc.css('a[href*="github"]').attribute('href').value unless doc.css('a[href*="github"]') == []
    hash[:blog] = doc.css('a:nth-child(4)').attribute('href').value unless doc.css('a:nth-child(4)') == []
    hash[:profile_quote] = doc.css('div.profile-quote').text
    hash[:bio] = doc.css('div.description-holder p').text
    hash
  end

end
