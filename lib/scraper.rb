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
    profile = Array.new
    links = page.css('.social-icon-container')
    url = link.css('a').attribute("href").value
    links.each do |link|
      if url.include?("twitter")
        twitter = url
      elsif url.include?("github")
        github = url
      elsif url.include?("linkedin")
        linkedin = url
      else
        blog = url
      end
      profile = {
        twitter: twitter,
        linkedin: linkedin,
        github: github,
        blog: blog,
        profile_quote: page.css('.profile-quote').text,
        bio: page.css("p").text
      }
    end
    profile
  end

end
