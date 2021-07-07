require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = Array.new
    student_cards = page.css('div.student-card')
    student_cards.each do |i|
      student = {
        name: i.css('.student-name').text,
        location: i.css('.student-location').text,
        profile_url: i.css('a')[0].attributes["href"].value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    profile = {}
    links = page.css('.social-icon-container').children.css('a').map { |e| e.attribute('href').value}
    links.each do |url|
      if url.include?("twitter")
        profile[:twitter] = url
      elsif url.include?("github")
        profile[:github] = url
      elsif url.include?("linkedin")
        profile[:linkedin] = url
      else
        profile[:blog] = url
      end
    end

    profile[:profile_quote] = page.css('.profile-quote').text
    profile[:bio] = page.css("p").text
    profile
  end

end
