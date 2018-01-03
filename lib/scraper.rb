require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_cards = index_page.css(".student-card")
    student_data = []
    student_cards.each_with_index do |student_card, index|
      student_data[index] = {
        :name => student_card.at_css('.student-name').inner_html,
        :location => student_card.at_css('.student-location').inner_html,
        :profile_url => student_card.at_css("a").attributes['href'].value
      }
    end
    student_data
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

