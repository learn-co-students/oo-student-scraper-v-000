require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) #returns students Array of hashes, each hash being a single student
    #keys: :name, :location, :profile_url
    students = []
    html = Nokogiri::HTML(index_url)

    html.css('div.student-card').each { |card|
      name = card.css('.student-name').text
      location = card.css('.student-location').text
      profile_url = card.css('a').attribute('href').value
      student = { :name => name, :location => location, :profile_url => profile_url }
      students << student
    }
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
