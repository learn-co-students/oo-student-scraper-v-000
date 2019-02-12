require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    scraped_students = []

    learn_students = doc.css('div.student-card')
    learn_students.map do |student_card|
      scraped_students = [
        {
          :name => doc.css('h4.student-name').text,
          :location => doc.css('p.student-location').text,
          :profile_url => doc.css('div.student-card a').attribute('href').value
         }
       ]
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)


  end

end

# name: doc.css('h4.student-name').text
# location: doc.css('p.student-location').text
# profile_url: doc.css('div.student-card a').attribute('href').value
