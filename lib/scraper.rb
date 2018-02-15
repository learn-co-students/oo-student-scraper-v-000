require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    roster = doc.css('.student-card')
    students = roster.map do |element|
      result = {}
      result[:name] = element.css('.student-name').text
      result[:location] = element.css('.student-location').text
      result[:profile_url] = element.css('a').attribute("href").value
      result
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    result = {}

    doc.css('.social-icon-container a').each do |element|
      link = element.attribute("href").value
      result[:github] = link if link.match(/.+github.+/)
      result[:twitter] = link if link.match(/.+twitter.+/)
      result[:linkedin] = link if link.match(/.+linkedin.+/)
    end

    result[:profile_quote] = doc.css('.profile-quote').text
    result[:bio] = doc.css('.description-holder p').text

    result
  end

end
