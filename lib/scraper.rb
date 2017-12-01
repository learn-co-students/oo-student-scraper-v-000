require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(index_page)
    index_array = []
    doc.css(".student-card a").each do |person|
      index_array << {
        :name => person.css(".student-name").text,
        :location => person.css(".student-location").text,
        :profile_url => "#{person.attr('href')}"
      }
    end
    index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    doc.css(".social-icon-container").children.css("a").each do |social|
      link = social.attribute('href').value
      if link.include?('twitter')
        profile_hash[:twitter] = link
      elsif link.include?('linkedin')
        profile_hash[:linkedin] = link
      elsif link.include?('github')
        profile_hash[:github] = link
      else link.include?('blog')
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css("p").text
    profile_hash
  end

end
