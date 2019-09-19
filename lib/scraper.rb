require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = doc.css('.student-card')
    hash_students = students.collect do |indiv|
      student = {}
      student[:name] = indiv.css('.student-name').text
      student[:location] = indiv.css('.student-location').text
      student[:profile_url] = indiv.css('a').attribute("href").value
      student
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = {}

    doc.css('.social-icon-container a').each do |ele|
      link = ele.attribute("href").value
      profile[:twitter] = link if link.match(/.+twitter.+/)
      profile[:linkedin] = link if link.match(/.+linkedin.+/)
      profile[:github] = link if link.match(/.+github.+/)
      profile[:blog] = link if ele
        .css('img')
        .attribute('src')
        .text
        .match(/.+rss.+/)
    end

    profile[:profile_quote] = doc.css('.profile-quote').text
    profile[:bio] = doc.css('.description-holder p').text

    profile
  end

end
