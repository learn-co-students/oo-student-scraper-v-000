require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)

    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))


    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        scraped_students << {
            :name => student.css("h4.student-name").text,
            :location => student.css("p.student-location").text,
            :profile_url => student.css("a").attribute("href").value
          }
          end
        end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
