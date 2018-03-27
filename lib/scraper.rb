require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_hashs = []
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('.student-card')
    student_cards.each do |student_card|
      student_hash = {}
      student_hash[:name] = student_card.css('.student-name')[0].text
      student_hash[:location] = student_card.css('.student-location')[0].text
      student_hash[:profile_url] = student_card.css('a').map{|link| link.attribute('href').to_s}[0]
      student_hashs << student_hash
    end
    student_hashs
  end

  def self.scrape_profile_page(profile_url)
    # data to get: name, location, twitter, linkedin
    # github, blog, profile_quote, bio, profile_url

    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    # profile_hash[:profile_url] = doc.css('a').map{|link| link.attribute('href').to_s}[0]
    profile_hash[:twitter] = doc.css("a[href*='twitter']").map{|link| link.attribute('href').to_s}[0]
    profile_hash[:linkedin] = doc.css("a[href*='linkedin']").map{|link| link.attribute('href').to_s}[0]
    profile_hash[:github] = doc.css("a[href*='github']").map{|link| link.attribute('href').to_s}[0]
    profile_hash[:blog] = doc.css("img[src*='../assets/img/rss-icon.png']").map{|link| link.parent.attribute('href').to_s}[0]
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".bio-content .description-holder p").text
    profile_hash.select{|k, v| !v.nil? }
  end

end
