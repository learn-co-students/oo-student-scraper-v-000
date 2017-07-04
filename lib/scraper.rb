require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css('div.student-card')
    student_cards.map do |student|
      {
        :name => student.css('h4').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').first['href']
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css('.social-icon-container a')
    profile_info = social_links.collect do |link|
      { link['href'].gsub(/(?:f|ht)tps?:\/[^\s]?w*\W/, "").split('.').first.to_sym => link['href'] }
    end
    # Push to profile_info Array, current state is Array of Hashes
    profile_info << { :profile_quote => doc.css('div.profile-quote').text }
    profile_info << { :bio => doc.css('.bio-content div.description-holder p').text }
    # Array of Hashes to (1) Hash
    profile_info = profile_info.reduce Hash.new, :merge

    profile_info = profile_info.each_pair.collect do |key, value|
      if key.to_s != 'linkedin' && key.to_s != 'twitter' && key.to_s != 'github' && key.to_s != 'profile_quote' && key.to_s != 'bio'
        {:blog => value}
      else
        {key => value}
      end
    end
    # Turns Array of Hashes into a Hash once more for return
    profile_info.reduce Hash.new, :merge
  end

end
