require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  # def get_page
  #
  # end

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |student|
    students << {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => "./fixtures/student-site/#{student.css("a").attr('href')}"
    }
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)

    profiles = {}

    links= profile_page.css("div.social-icon-container").children.css("a").collect {|url| url.attribute('href').value}
    links.each do |link|
      if link.include?('linkedin')
        profiles[:linkedin] = link
      elsif link.include?('github')
        profiles[:github] = link
      elsif link.include?('twitter')
        profiles[:twitter] = link
      else profiles[:blog] = link
      end
    end
        profiles[:profile_quote]=profile_page.css('div.profile-quote').text if profile_page.css('div.profile-quote')
        profiles[:bio]=profile_page.css('div.description-holder p').text if profile_page.css('div.description-holder p').text
    return profiles
  end
end
