require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    card = doc.css(".student-card")
    scraped_students = []
    card.each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
        }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
      html = File.read(profile_url)
      doc = Nokogiri::HTML(html)
      details = doc.css(".vitals-container")
      links_array = details.css(".social-icon-container a")
      links_array.each do |link|
        scraped_student[:github] = link["href"] if /github/.match(link["href"])
        scraped_student[:twitter] = link["href"] if /twitter/.match(link["href"])
        scraped_student[:linkedin] = link["href"] if /linkedin/.match(link["href"])
        scraped_student[:blog] = link["href"] if !/(github|linkedin|twitter)/.match(link["href"])
      end
      scraped_student[:profile_quote] = details.css(".profile-quote").text
      scraped_student[:bio] = doc.css(".details-container .bio-block .bio-content .description-holder p").text
      scraped_student
  end

end
