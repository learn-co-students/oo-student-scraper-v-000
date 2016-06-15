require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_page = Nokogiri::HTML(open (index_url))

    scraped_students = []

      learn_page.css("div.roster-cards-container").each do |card|
        card.css("div.student-card a").each do |student|
          scraped_students[title.to_sym] = {
            :name => student.css('.student-name').text,
            :location => student.css('.student-location').text,
            :profile_url => "http://127.0.0.1:4000/#{student.attr('href')}",
            }
        end
      end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    
  end

end

