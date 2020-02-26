require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").collect do |student|
      {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => "#{student.attr('href')}"}
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    doc.css(".social-icon-container a").collect{|link| link.attribute('href').value}.each do |link|
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else link.include?("blog")
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text
    profile
  end
end