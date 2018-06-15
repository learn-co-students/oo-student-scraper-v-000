#require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_scraper = Nokogiri::HTML(html)

    scraped_students = []
    i = 0
    student_scraper.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css('a').first['href']
      }
      i+=1
    end
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_scraper = Nokogiri::HTML(html)
    student_profile = {}
    links = profile_scraper.css("div.social-icon-container a")

    links.each do |link|
      if link['href'].include?('twitter')
        student_profile[:twitter] = link['href']
      elsif link['href'].include?('linkedin')
        student_profile[:linkedin] = link['href']
      elsif link['href'].include?('github')
        student_profile[:github] = link['href']
      else
        student_profile[:blog] = link['href']
      end
    end

    student_profile[:profile_quote] = profile_scraper.css('div.profile-quote').text
    student_profile[:bio] = profile_scraper.css('div.description-holder p').text

    student_profile

  end

end
