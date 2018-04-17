require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    scrape = Nokogiri::HTML(html)
    projects = []

    scrape.css(".student-card").each do |index|
      projects << {
      :name =>
      index.css('h4').text,
      :location =>
      index.css('p').text,
      :profile_url =>
      index.css('a').attribute('href').value
    }
    end
    projects
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    scrape = Nokogiri::HTML(html)
    scraped_student = Hash.new

  index =  scrape.css(".social-icon-container")
      i = 0
      while i < index.css('a').length
       if index.css('a')[i].attribute('href').value.include?('twitter')
      scraped_student[:twitter] =
        index.css('a')[i].attribute('href').value
      elsif index.css('a')[i].attribute('href').value.include?('linkedin')
    scraped_student[:linkedin] =
        index.css('a')[i].attribute('href').value
      elsif index.css('a')[i].attribute('href').value.include?('github')
      scraped_student[:github] =
        index.css('a')[i].attribute('href').value
      elsif index.css('a')[i].attribute('href').value.include?('facebook')
        scraped_student[:facebook] =
          index.css('a')[i].attribute('href').value
      else
      scraped_student[:blog] =
        index.css('a')[i].attribute('href').value
      end
      i += 1
    end

    scraped_student[:profile_quote] =
      scrape.css(".vitals-text-container").css('.profile-quote').text

    scrape.css('.details-container').map do |i|
      scraped_student[:bio] =
      i.css('p').text
    end
    scraped_student
  end

end
