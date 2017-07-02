require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = [] # Array to hold student hashes
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css('div.student-card')
    student_cards.each do |student|
      students << {
        :name => student.css('h4').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').first['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  end

end
