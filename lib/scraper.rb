require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = File.read('fixtures/student-site/index.html')
      doc = Nokogiri::HTML(html)

      students = []

      doc.css(".student-card").each do |student|
      students << {
      :name => student.css("div.card-text-container h4").text,
      :location => student.css("p").text,
      :profile_url => student.css('a').attr('href').value
      }
    end
    students
end

def self.scrape_profile_page(profile_url)
    scraper = Nokogiri::HTML(open(profile_url))
    attributes_hash = {}
    scraper.css(".social-icon-container a").each do |social|
      if social.attr("href").include?("twitter")
      attributes_hash[:twitter] = social.attr('href')
      elsif social.attr("href").include?("linkedin")
      attributes_hash[:linkedin] = social.attr('href')
      elsif social.attr("href").include?("github")
      attributes_hash[:github] = social.attr('href')
      else
      attributes_hash[:blog] = social.attr('href')
      end
    end
      attributes_hash[:profile_quote] = scraper.css("div.profile-quote").text
      attributes_hash[:bio] = scraper.css("div.description-holder p").text
      attributes_hash
   end
 end
