require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_scrape = Nokogiri::HTML(open(index_url))

    student_index_array = []

    index_scrape.css("div.student-card").each do |student|
      array_element = {
        :name => student.css("h4.student-name").text,
        :location => student.css("a div.card-text-container p.student-location").text,
        :profile_url => "#{student.css("a").attribute("href").value}"
      }
      student_index_array << array_element
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    student = {}

    profile.css('.social-icon-container a').each do |link|
      if link.attribute('href').text.include?('twitter')
        student[:twitter] = link.attribute('href').value
      elsif link.attribute('href').text.include?('linkedin')
        student[:linkedin] = link.attribute('href').value
      elsif link.attribute('href').text.include?('github')
        student[:github] = link.attribute('href').value
      else
        student[:blog] = link.attribute('href').value
      end
    end
    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('p').text

    student
  end
end
