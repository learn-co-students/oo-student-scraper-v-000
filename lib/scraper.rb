require 'open-uri'
require 'pry'
require_relative '../config.rb'

class Scraper


  def self.scrape_index_page(index_url)
  	html = Nokogiri::HTML(open(index_url))
  	all= [] 
  	html.css('.student-card').each do |card|
  		all << hash = {:name => card.css('a div.card-text-container h4.student-name').text, :location => card.css('a div.card-text-container p.student-location').text, :profile_url => index_url + card.css('a')[0]['href']}
  		end
  		return all
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    profile = {
    :twitter => !html.css('[href*="twitter.com"]')[0].nil? ? html.css('[href*="twitter.com"]')[0]['href'] : nil,
    :linkedin => html.css('[href*="linkedin.com"]')[0]['href'],
    :github => html.css('[href*="github.com"]')[0]['href'],
    :blog => !html.css('.social-icon-container a').select { |x| x['href'] == "http://joemburgess.com/"}[0].nil? ? html.css('.social-icon-container a').select { |x| x['href'] == "http://joemburgess.com/"}[0]['href'] : nil,
    :profile_quote => html.css('.profile-quote').text,
    :bio => html.css('.bio-content div.description-holder').text.strip!

}
	
	profile = profile.delete_if{|x,y| y.nil? }
	profile
  end

end

