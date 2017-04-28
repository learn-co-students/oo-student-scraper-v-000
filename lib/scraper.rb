require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
      students = []

      doc.css('.student-card').each do |student|
      name = student.children.css('h4').first.text
      location = student.children.css('p').first.text
      profile_url = "./fixtures/student-site/#{student.children.css('a').first.attributes['href'].value}"

      students.push({name: name, location: location, profile_url: profile_url})
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
binding.pry
    doc.css('.social-icon-container').each do |link|

      # twitter = ,
      # linkedin = ,
      # github = ,
      # blog = ,
      # profile_quote = ,
      # bio = >

    end
  end
end
