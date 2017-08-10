require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_pages = Nokogiri::HTML(html)

    scraped_students = []

    index_pages.css('div.student-card').each do |index_page|
      attribute = {:name => index_page.css('a div.card-text-container h4').text, :location => index_page.css('a div.card-text-container p').text, :profile_url => index_page.css('a').attribute("href").value}
      scraped_students << attribute
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    

  end

end
