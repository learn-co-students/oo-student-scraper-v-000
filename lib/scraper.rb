require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(File.read(index_url))
    students = []
    
    flatiron.css('div.student-card').each { |student|
      person = {
        name: student.css('h4.student-name').text,
        location: student.css('p.student-location').text,
        profile_url: student.css('a').attribute('href').value
      }
      students.push(person)
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
    binding.pry
  end

end

