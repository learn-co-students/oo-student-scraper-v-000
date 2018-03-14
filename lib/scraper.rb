require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('.student-card').each do |student|
      student_name = student.css('.student-name').text
      student_location = student.css('.student-location').text
      student_link = student.css('a').attribute("href").value
      student_link = './fixtures/student-site/' + student_link
      students_array << {name: student_name,
                         location: student_location,
                         profile_url: student_link}
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    student_hash[:profile_quote] = doc.css('.profile-quote').text
    student_hash[:bio] = doc.css('.bio-content p').text
    doc.css('.social-icon-container a').each do |link|

      link_value = link.attribute("href").value
      if link_value.include?('twitter')
        student_hash[:twitter] = link_value
      elsif link_value.include?('linkedin')
        student_hash[:linkedin] = link_value
      elsif link_value.include?('github')
        student_hash[:github] = link_value
      else
        student_hash[:blog] = link_value
      end

    end
    student_hash
  end
end
