require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # cards: index.css('div.roster-cards-container')
  # students: students.css('.student-card')
  # name: students.css('.card-text-container h4.student-name').text
  # location: students.css('.card-text-container p.student-location').text
  # profile_url: students.css('a').attribute('href').text.prepend('./fixtures/student-site/')

  def self.scrape_index_page(index_url)

    students = Nokogiri::HTML(open(index_url))

    students_array = []

    # binding.pry
    students.css('.student-card').each do |card|
      students_array << {
        :name => card.css('h4.student-name').text,
        :location => card.css('p.student-location').text,
        :profile_url => card.css('a').attribute('href').text.prepend('./fixtures/student-site/')
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    # info: student.css('.vitals-container')
    # profile_quote: profile.css('.profile-quote').text
    # bio: profile.css('p').text
    # twitter: profile.css('.social-icon-container a').attribute('href').text.include?('twitter')
    # all social icon children: profile.css('.social-icon-container').children.css('a')
    # iterate over each child
    # grab value of 'href'


    student = {}
    # binding.pry

    profile.css('.social-icon-container a').each do |link|
      if link.attribute('href').text.include?('twitter')
        student[:twitter] = link.attribute('href').value
      elsif link.attribute('href').text.include?('linkedin')
        student[:linkedin] = link.attribute('href').value
      elsif link.attribute('href').text.include?('github')
        student[:github] = link.attribute('href').value
      else
        student[:blog] = link.attribute('href').value
      end
    end
    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('p').text

      student
  end
end
