require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))
    students = []
    data.css('.student-card').each do |student|
      students << {
        name: student.css('.student-name').text,
        location: student.css('.student-location').text,
        profile_url: "#{index_url}#{student.css('a').attribute('href')}"
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    data = Nokogiri::HTML(open(profile_url))
    social_links = data.css(".social-icon-container a").collect { |link| link.attribute('href').value }
    for link in social_links
      if link.match(/twitter/)
        profile[:twitter] = link
      elsif link.match(/github/)
        profile[:github] = link
      elsif link.match(/linkedin/)
        profile[:linkedin] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = data.css(".profile-quote").text
    profile[:bio] = data.css(".description-holder p").text

    profile
  end

end
