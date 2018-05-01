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
    #retreive student page
    html = File.read(profile_url)
    #access HTML of stuent page
    infos = Nokogiri::HTML(html)

    #initializes student_profile as a has
    scraped_student = {}

    #scrapes the bio and assigns to student
    scraped_student[:bio] = infos.css('.details-container').css('p').text

    #assign all the social media attributes
    infos.css('.vitals-container').each do |attribute|

      scraped_student[:profile_quote] = attribute.css('.profile-quote').text
      scraped_student[:twitter] = attribute.css('a')[0]['href']
      scraped_student[:linkedin] = attribute.css('a')[1]['href']
      scraped_student[:github] = attribute.css('a')[2]['href'] unless attribute.css('a')[2] == nil
      scraped_student[:blog] = attribute.css('a')[3]['href'] unless attribute.css('a')[3] == nil
    end
    scraped_student
  end

end
