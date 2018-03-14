require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []

    doc.css('div.student-card').each do |student|

      h = {
        :name => student.css('a div.card-text-container h4.student-name').text,
        :location => student.css('div.card-text-container p.student-location').text,
        :profile_url => "./fixtures/student-site/" + student.css('a').attribute('href').value
      }
      students << h
  end
  students
end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_info = {}

    doc.css('body').each do |student|
      name = student.css('div.vitals-container div.vitals-text-container h1.profile-name').text
      social_links = student.css('div.social-icon-container a')
      student_info[name.to_sym]

        social_links.each do |site|
          if site.attribute('href').value.include?('twitter')
            student_info[:twitter] = site.attribute('href').value
          elsif site.attribute('href').value.include?('linkedin')
            student_info[:linkedin] = site.attribute('href').value
          elsif site.attribute('href').value.include?('github')
            student_info[:github] = site.attribute('href').value
          elsif site.attribute('href').value != ""
            student_info[:blog] = site.attribute('href').value
          end
        end
        student_info[:profile_quote] = student.css('div.vitals-container div.vitals-text-container div.profile-quote').text
        student_info[:bio] = student.css('div.details-container div.bio-block div.bio-content div.description-holder p').text
    end
    student_info
  end

end
