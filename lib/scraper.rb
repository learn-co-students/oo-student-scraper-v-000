require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))

  	array= []

	doc.css(".student-card").each do |card|
	hash = {}
	hash[:name] = card.css("a .student-name").text
	hash[:location] = card.css("a .student-location").text
	scraped_url = card.css("a").attribute("href").value
	hash[:profile_url] = "./fixtures/student-site/#{scraped_url}"

	array << hash
	end

	array

  end

  def self.scrape_profile_page(profile_url)
    return_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css('.social-icon-container a').each do |icon|
      if icon.css('img')[0]['src'].include?('rss-icon')
        return_hash[:blog] = icon['href']
      elsif icon['href'].include?('github')
        return_hash[:github] = icon['href']
      elsif icon['href'].include?('twitter')
        return_hash[:twitter] = icon['href']
      elsif icon['href'].include?('linkedin')
        return_hash[:linkedin] = icon['href']
      end
    end
    return_hash[:bio] = doc.css('.description-holder > p').text
    return_hash[:profile_quote] = doc.css('.profile-quote').text
    return_hash
  end

end
