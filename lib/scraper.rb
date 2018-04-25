require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    index_page.css('.student-card').collect do |student|
      { :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => student.css('a').first['href']}
    end
  end


# twitter url, linkedin url, github url, blog url, profile quote, and bio
  def self.scrape_profile_page(profile_url)
    student = {}

    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('.description-holder p').text

    social_media = profile.css('.social-icon-container a')
    social_links = social_media.map {|site| site['href']}
      social_links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        else
          student[:blog] = link
        end
      end
    student
  end

end
