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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    #binding.pry
    profile_hash = {}
    doc.css('div.social-icon-container a').each do |a|
      if a.attribute('href').value.include?("twitter")
        profile_hash[:twitter] = a.attribute('href').value
      elsif a.attribute('href').value.include?("linkedin")
        profile_hash[:linkedin] = a.attribute('href').value
      elsif a.attribute('href').value.include?("github")
        profile_hash[:github] = a.attribute('href').value
      else
        profile_hash[:blog] = a.attribute('href').value
      end
    end
    profile_hash[:profile_quote] = doc.css('div.profile-quote').text
    profile_hash[:bio] = doc.css('div.description-holder p').text
    profile_hash
  end

end
