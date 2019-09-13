require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    index.css('div.student-card').map do |e|
      {
        name: e.css('.student-name').text,
        location: e.css('.student-location').text,
        profile_url: e.css('a').attribute('href').value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile = {
      profile_quote: profile_page.css('.profile-quote').text,
      bio: profile_page.css('.bio-content p').text
    }
    profile_page.css('.social-icon-container a').each do |e|
      link = e.attributes['href'].value
      profile[:twitter] = link if link.match(/twitter/)
      profile[:linkedin] = link if link.match(/linkedin/)
      profile[:github] = link if link.match(/github/)
      profile[:blog] = link if link.match(/http:\/\//)
    end
    profile
  end

end
