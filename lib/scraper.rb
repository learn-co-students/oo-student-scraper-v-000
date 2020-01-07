#require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open("#{index_url}")
    index_page = Nokogiri::HTML(html)
    index_page.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    info = {}
    html = open("#{profile_url}")
    profile_page = Nokogiri::HTML(html)
    info[:profile_quote] = profile_page.css(".profile-quote").text
    info[:bio] = profile_page.css(".bio-block .description-holder p").text
    links = profile_page.css(".social-icon-container a").map {|icon| icon.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        info[:twitter] = link
      elsif link.include?("linkedin")
        info[:linkedin] = link
      elsif link.include?("github")
        info[:github] = link
      else
        info[:blog] = link
      end
    end
    info
  end

end

#name
#location
#profile-url
#twitter
#linkedin
#github
#blog
#profile_quote
#bio
