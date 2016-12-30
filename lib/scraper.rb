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
    page = Nokogiri::HTML(open(profile_url))
    socials = page.css('.social-icon-container a')
    quote = page.css('.profile-quote').text.strip
    bio = page.css('.bio-content.content-holder').css('.description-holder').text.strip
    profile = {}

    socials.each do |s|
      s = s.attribute('href').value
      if s.match(/twitter/)
        profile[:twitter] = s
      elsif s.match(/linkedin/)
        profile[:linkedin] = s
      elsif s.match(/github/)
        profile[:github] = s
      else
        profile[:blog] = s
      end
    end

    profile[:profile_quote] = quote
    profile[:bio]           = bio
    profile
  end
end
