require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_cards = []
    index_page = Nokogiri::HTML(open(index_url))
    index_url += '/' unless index_url[-1] == '/'
    index_page.css('div.student-card').each do |card|
      student_card_hash = {}
      student_card_hash[:name] = card.css('a div.card-text-container h4.student-name').text
      student_card_hash[:location] = card.css('a div.card-text-container p.student-location').text
      student_card_hash[:profile_url] = index_url + card.css('a').attribute('href').value
      student_cards << student_card_hash
    end
    student_cards
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    profile_page.css('div.social-icon-container a').each do |link|
      link_url = link.attributes['href'].value
      if /twitter/.match(link_url)
        profile_info[:twitter] = link_url
      elsif /github/.match(link_url)
        profile_info[:github] = link_url
      elsif /linkedin/.match(link_url)
        profile_info[:linkedin] = link_url
      elsif "#" == link_url
      else
        profile_info[:blog] = link_url
      end
    end 
    profile_info[:profile_quote] = profile_page.css('div.profile-quote').text
    profile_info[:bio] = profile_page.css('div.description-holder p').text
    profile_info
  end

end