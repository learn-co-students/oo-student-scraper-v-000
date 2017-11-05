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
    name = doc.css('h1.profile-name').text
    doc.css('div.social-icon-container a').each do |a|
      profile_hash[:twitter] = doc.css('a[href*="twitter"]').attribute('href').value if a.attribute('href').value.include?("twitter")
      profile_hash[:linkedin] = doc.css('a[href*="linkedin"]').attribute('href').value if a.attribute('href').value.include?("linkedin")
      profile_hash[:github] = doc.css('a[href*="github"]').attribute('href').value if a.attribute('href').value.include?("github")
      if doc.css('div.social-icon-container a')[3] != nil
        profile_hash[:blog] = doc.css('a:nth-child(4)').attribute('href').value if a.attribute('href').value.include?(name.downcase.split[0])
      end
    end
    profile_hash[:profile_quote] = doc.css('div.profile-quote').text
    profile_hash[:bio] = doc.css('div.description-holder p').text
    profile_hash
  end

end
