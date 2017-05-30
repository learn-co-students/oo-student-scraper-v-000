require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.get_page
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
  end

  def self.get_profile_page(url)
    html = File.read(url)
    doc = Nokogiri::HTML(html)
  end

  def self.scrape_index_page(index_url)
    students = get_page.css(".student-card")
    students.map do |e|
      student = {}
      student[:name] = e.css('.student-name').text
      student[:location] = e.css('.student-location').text
      student[:profile_url] = e.css('a').attribute('href').value
      student
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = get_profile_page(profile_url)
    vitals_data = profile_page.css(".vitals-container")
    vitals_data.css(".social-icon-container a").each do |e|
      social = e.attribute('href').value
      if social.match(/twitter/)
        student[:twitter] = social
      elsif social.match(/linkedin/)
        student[:linkedin] = social
      elsif social.match(/github/)
        student[:github] = social
      else
        student[:blog] = social
      end
    end
    student[:profile_quote] = vitals_data.css('.profile-quote').text
    student[:bio] = profile_page.css('.details-container p').text
    student
  end

end
