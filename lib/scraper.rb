require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    #binding.pry
    students = []

    index_page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_name = student.css('h4.student-name').text
        student_location = student.css('p.student-location').text
        student_profile_link = student.attr('href')
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end

#student: index_page.css('div.student-card')
#name: student.css('h4.student-name').text
#location: student.css('p.student-location').text
#profile_url: student.css('a').attribute('href').value

#card = index_page.css('div.roster-cards-container')
#first_student = card.css('.student-card a').first
