require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css('div.student-card').map do |s|
      {
          name:        s.css('.student-name').text,
          location:    s.css('.student-location').text,
          profile_url: "./fixtures/student-site/#{s.css('a').attribute('href').value}"
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
