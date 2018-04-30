require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #retreive student page
    html = File.read(index_url)
    #access HTML of stuent page
    students = Nokogiri::HTML(html)

    #initialize student hash as an empty hash
    students_array = []

    students.css('.student-card').each do |student|
      student_hash = {}

      student_hash[:name] = student.css('h4').text
      student_hash[:location] = student.css('p').text

      student_hash[:profile_url] = student.css('a').first['href']
      students_array << student_hash
    end
    students_array

  end

  def self.scrape_profile_page(profile_url)

  end

end
